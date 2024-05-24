
clear global;

% Modelando el error con Takagi-Sugeno
load("variables.mat");
delta = H_max/4;
Qmax = 0.2;

ts = sugfis();
% Entradas (error)
ts = addInput(ts, [-H_max, H_max], 'Name', 'error'); 
ts = addMF(ts, 'error', 'zmf', [(-H_max*(3/4) - delta) (-H_max*(3/4) + delta)], 'Name', 'NB'); % negativo grande
ts = addMF(ts, 'error', 'trimf', [(-H_max/2 - delta) (-H_max/2) (-H_max/2 + delta)], 'Name', 'NM'); % negativo mediano
ts = addMF(ts, 'error', 'trimf', [(-H_max/4 - delta) (-H_max/4) (-H_max/4 + delta)], 'Name', 'NS'); % negativo pequeño
ts = addMF(ts, 'error', 'trimf', [-delta 0 delta], 'Name', 'Z'); % cero
ts = addMF(ts, 'error', 'trimf', [(H_max/4 - delta) (H_max/4) (H_max/4 + delta)], 'Name', 'PS'); % positivo pequeño
ts = addMF(ts, 'error', 'trimf', [(H_max/2 - delta) (H_max/2) (H_max/2 + delta)], 'Name', 'PM'); % positivo mediano
ts = addMF(ts, 'error', 'smf', [(H_max*(3/4) - delta) (H_max*(3/4) + delta)], 'Name', 'PB'); % positivo grande

% Salidas (delta Q)
ts = addOutput(ts, [-Qmax, Qmax], 'Name', 'dQ');
ts = addMF(ts, 'dQ', 'constant', -Qmax, 'Name', 'NB'); % negativo grande
ts = addMF(ts, 'dQ', 'constant', -Qmax*(2/3), 'Name', 'NM'); % negativo mediano
ts = addMF(ts, 'dQ', 'constant', -Qmax/3, 'Name', 'NS'); % negativo pequeño
ts = addMF(ts, 'dQ', 'constant', 0, 'Name', 'Z'); % cero
ts = addMF(ts, 'dQ', 'constant', Qmax/3, 'Name', 'PS'); % positivo pequeño
ts = addMF(ts, 'dQ', 'constant', Qmax*(2/3), 'Name', 'PM'); % positivo mediano
ts = addMF(ts, 'dQ', 'constant', Qmax, 'Name', 'PB'); % positivo grande

% definir reglas
rules(1) = "error == NB => dQ = NB";
rules(2) = "error == NM => dQ = NM";
rules(3) = "error == NS => dQ = NS";
rules(4) = "error == Z => dQ = Z";
rules(5) = "error == PS => dQ = PS";
rules(6) = "error == PM => dQ = PM";
rules(7) = "error == PB => dQ = PB";
ts = addRule(ts, rules);

writeFIS(ts, 'error_fuzzy');
figure(1);
plotmf(ts, 'input', 1);
figure(2);
plotfis(ts);
