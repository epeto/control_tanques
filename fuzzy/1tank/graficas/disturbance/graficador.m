
clear all;

load("error.mat");

figure(1)
plot(error(1,:), zeros(size(error(1,:))), error(1,:), error(2,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
title('Error con perturbación');

