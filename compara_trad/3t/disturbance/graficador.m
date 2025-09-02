
clear all;

resized = [680, 458, 280, 210];

% Errores

error_pid = load("error_pid.mat", "error");
error_pid = error_pid.("error");

error_expert = load("error_expert.mat", "error");
error_expert = error_expert.("error");

error_fuzzy = load("error_fuzzy.mat", "error");
error_fuzzy = error_fuzzy.("error");

figure(1)
plot(error_pid(1,:), zeros(size(error_pid(1,:))), error_pid(1,:), error_pid(2,:)*100, error_expert(1,:), error_expert(2,:)*100, ...
    error_fuzzy(1,:), error_fuzzy(2,:)*100, 'linewidth', 1);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
legend('0', 'PID', 'Experto', 'Borroso');
title('Error c/p t1');
set(gcf, 'Position', resized);

figure(2)
plot(error_pid(1,:), zeros(size(error_pid(1,:))), error_pid(1,:), error_pid(3,:)*100, error_expert(1,:), error_expert(3,:)*100, ...
    error_fuzzy(1,:), error_fuzzy(3,:)*100, 'linewidth', 1);
grid on;
xlabel('tiempo (s)');
ylabel('error (cm)');
legend('0', 'PID', 'Experto', 'Borroso');
title('Error c/p t2');
set(gcf, 'Position', resized);
