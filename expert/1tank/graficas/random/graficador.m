
clear all;

load("altura.mat");
load("error.mat");
load("flujo.mat");

figure(1)
plot(altura(1,:), altura(2,:)*100, altura(1,:), altura(3,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('altura (cm)');
legend('H*', 'H');
title('Altura');

figure(2)
plot(error(1,:), zeros(size(error(1,:))), error(1,:), error(2,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
title('Error');

figure(3)
plot(flujo(1,:), flujo(2,:)*1000, 'linewidth',1.5);
grid on;
xlabel('tiempo (s)');
ylabel('flujo (mL/s)');
title('Flujo');
