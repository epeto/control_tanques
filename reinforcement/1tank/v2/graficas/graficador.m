% Refuerzo -> 1 variable

H_star = 0.31; % valor de referencia
st = 0.2; % periodo en segundos

load("altura.mat");
load("error.mat");
load("signal.mat");

longitud = error.Length;
ref_error = zeros(1, longitud);
ref_altura = zeros(1, longitud) + H_star;
time = zeros(1, longitud);

for i=2:longitud
    time(i) = time(i-1) + st;
end

figure(1)
plot(time, ref_altura, 'b', time, altura.Data, 'r', 'linewidth', 1.5);
xlabel('tiempo (s)');
ylabel('altura (m)');

figure(2)
plot(time, ref_error, 'b', time, error.Data(1:limite), 'r', 'linewidth', 1.5);
xlabel('tiempo (s)');
ylabel('error (m)');

signal_filtrada = signal(2,:);

figure(3)
plot(time(1:limite), signal_filtrada(1:limite), 'b', 'linewidth',1.5);
xlabel('tiempo (s)');
ylabel('flujo (L/s)');

