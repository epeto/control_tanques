
clear all;

load("error.mat");
resized = [680, 458, 280, 210];

figure(1)
plot(error(1,:), zeros(size(error(1,:))), error(1,:), error(2,:)*100, error(1,:), error(3,:)*100, 'linewidth', 1);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
legend('0', 'error 1', 'error 2');
title('Errores con perturbación');
set(gcf, 'Position', resized);
