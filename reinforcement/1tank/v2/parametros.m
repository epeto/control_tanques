
A1 = 0.0154;
A2 = 5e-5;
az = 0.5;
H_max = 0.62;
g = 9.8;
ro = 1000;
Qmax = 0.1;
H_star = H_max/2;
H_ini = 0; % altura inicial
Q_star = ro*A2*az*sqrt(2*g*H_star);
st = 0.2; % sample time
epsilon = 0.005;

save("variables.mat", "A1", "A2", "az", "H_max", "g", "ro", "Qmax", "H_star", "H_ini", "Q_star");
