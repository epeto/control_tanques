
clear all;

load("altura.mat");
load("error.mat");
load("signal.mat");

figure(1)
plot(altura(1,:), altura(3,:)*100, altura(1,:), altura(2,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('altura (cm)');
legend('H*', 'H');

figure(2)
plot(error(1,:), zeros(size(error(1,:))), error(1,:), error(2,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');

figure(3)
plot(signal(1,:), signal(2,:)*1000, 'linewidth',1.5);
grid on;
xlabel('tiempo (s)');
ylabel('flujo (mL/s)');

