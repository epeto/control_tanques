
clear all;

resized = [680, 458, 280, 210];

% Alturas
altura_predictive = load("altura_predictive.mat", "altura");
altura_predictive = altura_predictive.("altura");

altura_rl = load("altura_rl.mat", "altura");
altura_rl = altura_rl.("altura");

figure(1)
plot(altura_predictive(1,:), altura_predictive(2,:)*100, altura_predictive(1,:), altura_predictive(3,:)*100, ...
    altura_rl(1,:), altura_rl(3,:)*100, 'linewidth', 1);
grid on;
xlabel('tiempo (s)');
ylabel('nivel (cm)');
legend('Referencia', 'Predictivo', 'Refuerzo');
title('Nivel: comparación');
set(gcf, 'Position', resized);

% Errores
error_predictive = load("error_predictive.mat", "error");
error_predictive = error_predictive.("error");

error_rl = load("error_rl.mat", "error");
error_rl = error_rl.("error");

figure(2)
plot(error_predictive(1,:), zeros(size(error_predictive(1,:))), error_predictive(1,:), error_predictive(2,:)*100, ...
    error_rl(1,:), error_rl(2,:)*100, 'linewidth', 1);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
legend('0', 'Predictivo', 'Refuerzo');
title('Error s/p: comparación');
set(gcf, 'Position', resized);

% Flujos
flujo_predictive = load("flujo_predictive.mat", "flujo");
flujo_predictive = flujo_predictive.("flujo");

flujo_rl = load("flujo_rl.mat", "flujo");
flujo_rl = flujo_rl.("flujo");

figure(3)
plot(flujo_predictive(1,:), flujo_predictive(2,:)*1000, flujo_rl(1,:), flujo_rl(2,:)*1000, 'linewidth', 1);
grid on;
xlabel('tiempo (s)');
ylabel('flujo (mL/s)');
legend('Predictivo', 'Refuerzo');
title('Flujo: comparación');
set(gcf, 'Position', resized);

