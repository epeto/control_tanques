
clear global;

Sn = 5e-5;
A = 0.0154;
H_max = 0.62;
H_star1 = 0.4; % altura objetivo 1
H_star2 = 0.15; % altura objetivo 2
Qmax = 0.1;
g = 9.8;
az1 = 1;
az2 = 1;
az3 = 1;
epsilon = 0.005;

save("variables.mat", "Sn", "A", "H_max", "H_star1", "H_star2", "g", "az1", "az2", "az3", "epsilon", "Qmax");

open("rl_3tank.slx");
