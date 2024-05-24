
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
st = 0.2; % sampling time
semilla = 751;
e1 = 5e-3;
e2 = 1e-3;
e3 = 5e-4;
e4 = 1e-4;

save("variables.mat", "A1", "A2", "az", "H_max", "ro", "Qmax", "H_star", "g", "H_ini", "Q_star", "e1", "e2", "e3", "e4", "semilla");
