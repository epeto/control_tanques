
clear global;

Sn = 5e-5;
A = 0.0154;
H_max = 0.62;
H_star1 = 0.4; % valor de referencia 1
H_star2 = 0.15; % valor de referencia 2
g = 9.8;

az1 = 1;
az2 = 1;
az3 = 1;

st = 0.2;
Qmax = 0.2;

semilla1 = 751;
semilla2 = 131;

save("variables.mat", "Sn", "A", "H_max", "H_star1", "H_star2", "g", "az1", "az2", "az3", "Qmax", "st", "semilla1", "semilla2");
%open("flc_3tank.slx");
