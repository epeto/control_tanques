
A1 = 0.0154;
A2 = 5e-5;
az = 0.5;
H_max = 0.62;
g = 9.8;
ro = 1000;
Qmax = 0.1; % L/s
H_star = H_max/2;
Q_star = ro*A2*az*sqrt(2*g*H_star);
st = 0.2; % sampling time
semilla = 751;

% parámetros del controlador pid
kp = 0.73979;
ki = 0.01351;
kd = 1.07916;
N = 0.05171;

save("variables.mat", "A1", "A2","az", "H_max", "g", "ro", "Qmax", "H_star", "Q_star", "st", "kp", "ki", "kd", "N", "semilla");
run("pid_tanque_v2");
