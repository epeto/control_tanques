
Sn = 5e-5;
A = 0.0154;
Hmax = 0.62;
H_star1 = 0.4; % setpoint 1
H_star2 = 0.15; % setpoint 2
Qmax = 0.1; % L/s
g = 9.8;

az1 = 1;
az2 = 1;
az3 = 1;

kp = 1.06160;
ki = 0.03014;
kd = -2.20023;
N = 0.10176;

%kp = 0.73979;
%ki = 0.01351;
%kd = 1.07916;
%N = 0.05171;

semilla1 = 751;
semilla2 = 131;

st = 0.2;

save("variables.mat", "Sn", "A", "Hmax", "H_star1", "H_star2", "g", "az1", ...
    "az2", "az3", "kp", "ki", "kd", "N", "st", "Qmax", "semilla1", "semilla2");

%open("pid_3tank.slx");

