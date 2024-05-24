
load("variables.mat"); % se cargan las variables
modelo = "rl_watertank";
open(modelo);

% Acción
actionInfo = rlNumericSpec([1 1]); % recibe la dimensión de la acción: en este caso, 1 fila y 1 columna
actionInfo.Name = "flujo";

% Observación
open_system(modelo + "/observacion"); % abre el subsistema de simulink asociado a la observación
% la observación es un arreglo de 3x1 (ie, e, h)
observationInfo = rlNumericSpec([3 1], LowerLimit=transpose([-inf -inf 0]), UpperLimit=transpose([inf inf inf]));
observationInfo.Name = "observaciones";
observationInfo.Description = "error integral, error, altura";

% Recompensa
open_system(modelo + "/recompensa"); % abre el subsistema asociado a la recompensa

% Terminado
open_system(modelo + "/fuera de rango"); % abre el subsistema asociado a la terminación de un episodio

% Ambiente
env = rlSimulinkEnv(modelo, modelo + "/RL Agent", observationInfo, actionInfo);
env.ResetFcn = @(in)localResetFcn(in);

% función para reinicio aleatorio
function in = localResetFcn(in)
    H_max = 0.62;
    % Randomize initial height
    h = randn + H_max/2;
    while h <= 0 || h >= H_max
        h = randn + H_max/2;
    end
    bloque = "rl_watertank/Tanque/Altura";
    in = setBlockParameter(in, bloque, InitialCondition=num2str(h));
end
