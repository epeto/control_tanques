
clear global;
% En este script se entrena y se prueba un agente de aprendizaje por refuerzo con el algoritmo Deep Deterministic Policy Gradient (DDPG)

% Nota: en esta versión se utiliza la arquitectura de red que aparece en:
% https://la.mathworks.com/help/reinforcement-learning/ug/create-simulink-environment-and-train-agent.html

% Primera parte: crear el ambiente (lo mismo que el script 'ambiente.m')
load("variables.mat"); % se cargan las variables
modelo = "rl_watertank";
open_system(modelo);

% Acción
actInfo = rlNumericSpec([1 1]); % recibe la dimensión de la acción: en este caso, 1 fila y 1 columna
actInfo.Name = "flujo";

% Observación
% la observación es un arreglo de 3x1 (ie, e, h)
obsInfo = rlNumericSpec([3 1], LowerLimit=transpose([-inf -inf 0]), UpperLimit=transpose([inf inf inf]));
obsInfo.Name = "observaciones";
obsInfo.Description = "error integral, error, altura";

% Ambiente
env = rlSimulinkEnv(modelo, modelo + "/RL Agent", obsInfo, actInfo);
env.ResetFcn = @(in)localResetFcn(in);

Ts = 1; % sample time
Tf = 300; % tiempo de finalización

semilla = 750; % para reproducir resultados
rng(semilla);

% --------------------------------------------------------------
% Segunda parte: crear al crítico (red neuronal para función Q)

% Entrada 1: observación
obsPath = [
    featureInputLayer(obsInfo.Dimension(1), Name="obsInLyr")
    fullyConnectedLayer(50)
    reluLayer
    fullyConnectedLayer(25,Name="obsPathOutLyr")];

% Entrada 2: acción
actPath = [
    featureInputLayer(actInfo.Dimension(1),Name="actInLyr")
    fullyConnectedLayer(25,Name="actPathOutLyr")];

% Trayectoria común
commonPath = [
    additionLayer(2,Name="add")
    reluLayer
    fullyConnectedLayer(1,Name="QValue")];

criticNetwork = layerGraph();
criticNetwork = addLayers(criticNetwork, obsPath);
criticNetwork = addLayers(criticNetwork, actPath);
criticNetwork = addLayers(criticNetwork, commonPath);
criticNetwork = connectLayers(criticNetwork, "obsPathOutLyr", "add/in1");
criticNetwork = connectLayers(criticNetwork, "actPathOutLyr", "add/in2");

% Se observa la arquitectura de la red
figure
plot(criticNetwork);

% Crear un objeto (red neuronal) del tipo dlnetwork
criticNetwork = dlnetwork(criticNetwork);
%disp(summary(criticNetwork));

% Función de aproximación para el crítico
critic = rlQValueFunction(criticNetwork, obsInfo,actInfo, ObservationInputNames="obsInLyr", ActionInputNames="actInLyr");

% se puede observar un forward del crítico
% getValue(critic, {rand(obsInfo.Dimension)}, {rand(actInfo.Dimension)})

% -------------------------------------------------------------------
% Tercera parte: crear al actor (red neuronal asociada a la política)

actorNetwork = [
    featureInputLayer(obsInfo.Dimension(1))
    fullyConnectedLayer(3)
    tanhLayer
    fullyConnectedLayer(actInfo.Dimension(1))
    sigmoidLayer]; % función sigmoide agregada, para acotar entre 0 y 1

% crear objeto dlnetwork
actorNetwork = dlnetwork(actorNetwork);
%disp(summary(actorNetwork));

% crear función de aproximación
actor = rlContinuousDeterministicActor(actorNetwork,obsInfo,actInfo);

% se puede observar un forward del actor
% getAction(actor, {rand(obsInfo.Dimension)}

% ----------------------------------
% Cuarta parte: crear el agente DDPG

agent = rlDDPGAgent(actor, critic);

% parámetros obtenidos del paper:
% continuous control with deep reinforcement learning
agent.SampleTime = Ts;

agent.AgentOptions.TargetSmoothFactor = 1e-3;
agent.AgentOptions.DiscountFactor = 0.99;
agent.AgentOptions.MiniBatchSize = 64;
agent.AgentOptions.ExperienceBufferLength = 1e6;

agent.AgentOptions.NoiseOptions.Variance = 0.1; % cambié de 0.3 -> 0.1
agent.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-5;

agent.AgentOptions.CriticOptimizerOptions.LearnRate = 1e-03;
agent.AgentOptions.CriticOptimizerOptions.GradientThreshold = 1;
agent.AgentOptions.ActorOptimizerOptions.LearnRate = 1e-04;
agent.AgentOptions.ActorOptimizerOptions.GradientThreshold = 1;

% Se puede verificar una acción
% getAction(agent, {rand(obsInfo.Dimension)})

% -----------------------------------
% Quinta parte: fase de entrenamiento
trainOpts = rlTrainingOptions(...
    MaxEpisodes = 1000, ... % TODO cambiar
    MaxStepsPerEpisode=ceil(Tf/Ts), ...
    ScoreAveragingWindowLength=20, ...
    Verbose=false, ...
    Plots="training-progress",...
    StopTrainingCriteria="AverageReward",...
    StopTrainingValue=100000); % modificado 10000 -> 100000

% Se guardará el estado del agente cuando haya terminado
doTraining = true; % cambiar a false cuando ya se haya entrenado

if doTraining
    trainingStats = train(agent, env, trainOpts);
    save("agenteDDPG.mat", "agent");
else
    load("agenteDDPG.mat", "agent");
end

% ----------------------------
% Sexta parte: fase de control
rng(semilla);
simOpts = rlSimulationOptions(MaxSteps=ceil(Tf/Ts), StopOnError="on"); % cambiando stop on error -> off
experiences = sim(env,agent,simOpts);

% Función para reinicio aleatorio

function in = localResetFcn(in)
    H_max = 0.62;

    % Randomize reference signal
    blk = "rl_watertank/Goal";
    h = randn + H_max/2;
    while h <= 0 || h >= H_max
        h = randn + H_max/2;
    end
    in = setBlockParameter(in, blk, Value=num2str(h));

    % Randomize initial height
    h = randn + H_max/2;
    while h <= 0 || h >= H_max
        h = randn + H_max/2;
    end
    bloque = "rl_watertank/Tanque/Altura";
    in = setBlockParameter(in, bloque, InitialCondition=num2str(h));
end

