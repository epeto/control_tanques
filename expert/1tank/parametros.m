% Constantes de la planta
A1 = 0.0154;
A2 = 5e-5;
az = 0.5;
H_max = 0.62;
g = 9.8;
ro = 1000;
Qmax = 0.5;
Qmin = 0;
H_star = H_max/2;
Q_star = ro*A2*az*sqrt(2*g*H_star);
st = 0.001; % sampling time
epsilon = 0.001;
semilla = 751;

save("variables.mat", "ro", "st", "Q_star", "Qmax", "Qmin", "A1", "A2", "az", "H_max", "H_star", "g", "epsilon", "semilla");
%run("expert_simu");
