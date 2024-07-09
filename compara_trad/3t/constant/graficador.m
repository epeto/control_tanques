
clear all;

% Alturas
altura_pid = load("altura_pid.mat", "altura");
altura_pid = altura_pid.("altura");

altura_expert = load("altura_expert.mat", "altura");
altura_expert = altura_expert.("altura");

altura_fuzzy = load("altura_fuzzy.mat", "altura");
altura_fuzzy = altura_fuzzy.("altura");

figure(1)
plot(altura_pid(1,:), altura_pid(2,:)*100, altura_pid(1,:), altura_pid(4,:)*100, altura_expert(1,:), altura_expert(4,:)*100, ...
    altura_fuzzy(1,:), altura_fuzzy(4,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('altura (cm)');
legend('Referencia', 'PID', 'Experto', 'Borroso');
title('Altura en tanque 1');

figure(2)
plot(altura_pid(1,:), altura_pid(3,:)*100, altura_pid(1,:), altura_pid(6,:)*100, altura_expert(1,:), altura_expert(6,:)*100, ...
    altura_fuzzy(1,:), altura_fuzzy(6,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('altura (cm)');
legend('Referencia', 'PID', 'Experto', 'Borroso');
title('Altura en tanque 2');

% Errores

error_pid = load("error_pid.mat", "error");
error_pid = error_pid.("error");

error_expert = load("error_expert.mat", "error");
error_expert = error_expert.("error");

error_fuzzy = load("error_fuzzy.mat", "error");
error_fuzzy = error_fuzzy.("error");

figure(3)
plot(error_pid(1,:), zeros(size(error_pid(1,:))), error_pid(1,:), error_pid(2,:)*100, error_expert(1,:), error_expert(2,:)*100, ...
    error_fuzzy(1,:), error_fuzzy(2,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
legend('0', 'PID', 'Experto', 'Borroso');
title('Error sin perturbación en tanque 1');

figure(4)
plot(error_pid(1,:), zeros(size(error_pid(1,:))), error_pid(1,:), error_pid(3,:)*100, error_expert(1,:), error_expert(3,:)*100, ...
    error_fuzzy(1,:), error_fuzzy(3,:)*100, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
legend('0', 'PID', 'Experto', 'Borroso');
title('Error sin perturbación en tanque 2');

% Flujos
flujo_pid = load("flujo_pid.mat", "flujo");
flujo_pid = flujo_pid.("flujo");

flujo_expert = load("flujo_expert.mat", "flujo");
flujo_expert = flujo_expert.("flujo");

flujo_fuzzy = load("flujo_fuzzy.mat", "flujo");
flujo_fuzzy = flujo_fuzzy.("flujo");

figure(5)
plot(flujo_pid(1,:), flujo_pid(2,:)*1000, flujo_expert(1,:), flujo_expert(2,:)*1000, ...
    flujo_fuzzy(1,:), flujo_fuzzy(2,:)*1000, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('flujo (mL/s)');
legend('PID', 'Experto', 'Borroso');
title('Flujo en bomba 1');

figure(6)
plot(flujo_pid(1,:), flujo_pid(3,:)*1000, flujo_expert(1,:), flujo_expert(3,:)*1000, ...
    flujo_fuzzy(1,:), flujo_fuzzy(3,:)*1000, 'linewidth', 1.5);
grid on;
xlabel('tiempo (s)');
ylabel('flujo (mL/s)');
legend('PID', 'Experto', 'Borroso');
title('Flujo en bomba 2');
