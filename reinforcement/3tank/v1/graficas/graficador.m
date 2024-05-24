
clear variables;

H_star1 = 0.4;
H_star2 = 0.15;
st = 0.2;

load("h1.mat");
load("h2.mat");
load("h3.mat");
load("error1.mat");
load("error2.mat");
load("flujo1.mat");
load("flujo2.mat");

shape = size(h1);
longitud = shape(2);

ref_h1 = zeros(1,longitud) + H_star1;
ref_h2 = zeros(1,longitud) + H_star2;
time = h1(1,:);

figure(1)
plot(time, ref_h1, time, ref_h2, time, h1(2,:), time, h2(2,:), time, h3(2,:), 'linewidth', 1.5);
xlabel('tiempo (s)');
ylabel('altura (m)');
legend('h1*', 'h2*', 'h1', 'h2', 'h3');

figure(2)
plot(time, zeros(1, longitud), time, error1(2,:), time, error2(2,:), 'linewidth', 1.5);
xlabel('tiempo (s)');
ylabel('error (m)');
legend('ref', 'error1', 'error2');

figure(3)
plot(time, flujo1(2,:), time, flujo2(2,:), 'linewidth', 1.5);
xlabel('tiempo (s)');
ylabel('flujo (L/s)');
legend('Q1', 'Q2');
