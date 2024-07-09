
clear all;

% Alturas
altura_predictive = load("altura_predictive.mat", "altura");
altura_predictive = altura_predictive.("altura");

altura_rl = load("altura_rl.mat", "altura");
altura_rl = altura_rl.("altura");

figure(1)
plot(altura_predictive(1,:), altura_predictive(2,:)*100, altura_predictive(1,:), altura_predictive(4,:)*100, ...
    altura_rl(1,:), altura_rl(4,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('altura (cm)');
legend('Referencia', 'Predictivo', 'Refuerzo');
title('Altura en tanque 1');

figure(2)
plot(altura_predictive(1,:), altura_predictive(3,:)*100, altura_predictive(1,:), altura_predictive(6,:)*100, ...
    altura_rl(1,:), altura_rl(6,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('altura (cm)');
legend('Referencia', 'Predictivo', 'Refuerzo');
title('Altura en tanque 2');

% Errores

error_predictive = load("error_predictive.mat", "error");
error_predictive = error_predictive.("error");

error_rl = load("error_rl.mat", "error");
error_rl = error_rl.("error");

figure(3)
plot(error_predictive(1,:), zeros(size(error_predictive(1,:))), error_predictive(1,:), error_predictive(2,:)*100, ...
    error_rl(1,:), error_rl(2,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
legend('0', 'Predictivo', 'Refuerzo');
title('Error sin perturbación en tanque 1');

figure(4)
plot(error_predictive(1,:), zeros(size(error_predictive(1,:))), error_predictive(1,:), error_predictive(3,:)*100, ...
    error_rl(1,:), error_rl(3,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
legend('0', 'Predictivo', 'Refuerzo');
title('Error en tanque 2');

% Flujos
flujo_predictive = load("flujo_predictive.mat", "flujo");
flujo_predictive = flujo_predictive.("flujo");

flujo_rl = load("flujo_rl.mat", "flujo");
flujo_rl = flujo_rl.("flujo");

figure(5)
plot(flujo_predictive(1,:), flujo_predictive(2,:)*1000, flujo_rl(1,:), flujo_rl(2,:)*1000, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('flujo (mL/s)');
legend('Predictivo', 'Refuerzo');
title('Flujo en bomba 1');

figure(6)
plot(flujo_predictive(1,:), flujo_predictive(3,:)*1000, flujo_rl(1,:), flujo_rl(3,:)*1000, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('flujo (mL/s)');
legend('Predictivo', 'Refuerzo');
title('Flujo en bomba 2');

