
clear all;

load("error.mat");

tiempo = error(1,:);
error_t1 = error(2,:)*100;
error_t2 = error(3,:)*100;

st1 = 438;
st2 = 685.5;

[mint1, maxt1] = minimax(error_t1, tiempo, st1);
[mint2, maxt2] = minimax(error_t2, tiempo, st2);

disp("Mínimo t1: " + mint1);
disp("Máximo t1: " + maxt1);
disp("Mínimo t2: " + mint2);
disp("Máximo t2: " + maxt2);

function [minimo, maximo] = minimax(errores, tiempo, settling_time)
    minimo = 1000;
    maximo = -1000;
    for i=1:size(tiempo,2)
        if tiempo(i) > settling_time
            if errores(i) > maximo
                maximo = errores(i);
            end
            if errores(i) < minimo
                minimo = errores(i);
            end
        end
    end
end
