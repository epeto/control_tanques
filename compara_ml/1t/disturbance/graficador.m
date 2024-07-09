
clear all;

% Errores
error_predictive = load("error_predictive.mat", "error");
error_predictive = error_predictive.("error");

error_rl = load("error_rl.mat", "error");
error_rl = error_rl.("error");

figure(2)
plot(error_predictive(1,:), zeros(size(error_predictive(1,:))), error_predictive(1,:), error_predictive(2,:)*100, ...
    error_rl(1,:), error_rl(2,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
legend('0', 'Predictivo', 'Refuerzo');
title('Error con perturbación: comparación');

