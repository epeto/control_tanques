
clear all;

load("altura.mat");
load("error.mat");
load("flujo.mat");
resized = [680, 458, 280, 210];

figure(1)
plot(altura(1,:), altura(2,:)*100, altura(1,:), altura(3,:)*100, altura(1,:), altura(4,:)*100,altura(1,:), altura(5,:)*100, altura(1,:), altura(6,:)*100, 'linewidth', 1);
grid on;
xlabel('tiempo (s)');
ylabel('nivel (cm)');
%legend('H1*', 'H2*', 'H1', 'H3', 'H2');
title('Niveles');
set(gcf, 'Position', resized);

figure(2)
plot(error(1,:), zeros(size(error(1,:))), error(1,:), error(2,:)*100, error(1,:), error(3,:)*100, 'linewidth', 1);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
legend('0', 'error 1', 'error 2');
title('Errores sin perturbación');
set(gcf, 'Position', resized);

figure(3)
plot(flujo(1,:), flujo(2,:)*1000, flujo(1,:), flujo(3,:)*1000, 'linewidth',1);
grid on;
xlabel('tiempo (s)');
ylabel('flujo (mL/s)');
legend('Q1', 'Q2');
title('Flujos');
set(gcf, 'Position', resized);
