
clear all;

load("error.mat");

tiempo = error(1,:);
errores = error(2,:)*100;

settling_time = 94;
cota_superior = -1000;
cota_inferior = 1000;

% Calcula el máximo y el mínimo después del tiempo de asentamiento
disp(size(tiempo,2));
for i=1:size(tiempo,2)
    if tiempo(i) > settling_time
        if errores(i) > cota_superior
            cota_superior = errores(i);
        end
        if errores(i) < cota_inferior
            cota_inferior = errores(i);
        end
    end
end

disp("Mínimo: "+cota_inferior);
disp("Máximo: "+cota_superior);
disp("Magnitud: "+(cota_superior - cota_inferior));