
Sn = 5e-5;
A = 0.0154;
Hmax = 0.62;
H_star1 = 0.4; % setpoint 1
H_star2 = 0.15; % setpoint 2
g = 9.8;
az1 = 1;
az2 = 1;
az3 = 1;
semilla1 = 751;
semilla2 = 131;

st = 0.001;

save("variables.mat", "Sn", "A", "Hmax", "H_star1", "H_star2", "g", "az1", "az2", "az3", "st", "semilla1", "semilla2");
%open("expert_3t.slx");

