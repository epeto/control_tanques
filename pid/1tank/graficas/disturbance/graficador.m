
clear all;

load("error.mat");

figure(2)
plot(error(1,:), zeros(size(error(1,:))), error(1,:), error(2,:)*100, 'linewidth', 1);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
title('Error con perturbación');
resized = [680, 458, 280, 210];
set(gcf, 'Position', resized);