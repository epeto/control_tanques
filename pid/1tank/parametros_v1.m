A1 = 0.0154;
A2 = 5e-5;
az = 0.5;
H_max = 0.62;
g = 9.8;
ro = 1000;
Qmax = 0.1;
H_star = 0.32;
Q_star = ro*A2*az*sqrt(2*g*H_star);
num1 = 1/(ro*A1);
den1 = 1;
den2 = ((az*A2)^2*g*ro)/(A1*Q_star);

% parámetros del controlador pid
run("pid_tanque_v1");
