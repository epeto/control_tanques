
% Nos sirve para cargar las variables (presupone que ya existen datos de entrenamiento.)

load("variables.mat");
load("training_data.mat");

% Creación de arrays para la fase de entrenamiento.
%tiempo = training_data(1,:);
input_td = training_data(2,:);
output_td = training_data(3,:);
run("nn_random.slx");
