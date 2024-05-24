
clear global;

Sn = 5e-5;
A = 0.0154;
H_max = 0.62;
H_star = 0.31; % valor de referencia
Qmax = 0.1;
g = 9.8;
az1 = 1;
az2 = 1;
az3 = 1;

semilla = 751;

save("variables.mat", "Sn", "A", "H_max", "H_star", "g", "az1", ...
    "az2", "az3", "Qmax", "semilla");

%open("rl_3tank.slx");
