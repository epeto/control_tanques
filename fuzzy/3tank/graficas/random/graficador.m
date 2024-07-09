
clear all;

load("altura.mat");
load("error.mat");
load("flujo.mat");

figure(1)
plot(altura(1,:), altura(2,:)*100, altura(1,:), altura(3,:)*100, altura(1,:), altura(4,:)*100,altura(1,:), altura(5,:)*100, altura(1,:), altura(6,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('altura (cm)');
legend('H1*', 'H2*', 'H1', 'H3', 'H2');
title('Alturas');

figure(2)
plot(error(1,:), zeros(size(error(1,:))), error(1,:), error(2,:)*100, error(1,:), error(3,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
legend('0', 'error 1', 'error 2');
title('Errores');

figure(3)
plot(flujo(1,:), flujo(2,:)*1000, flujo(1,:), flujo(3,:)*1000, 'linewidth',1.5);
grid on;
xlabel('tiempo (s)');
ylabel('flujo (mL/s)');
legend('Q1', 'Q2');
title('Flujos');

