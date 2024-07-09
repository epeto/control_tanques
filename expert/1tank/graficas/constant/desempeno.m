
% Se calculan las medidas de desempeño: Overshoot, Settling time,
% Steady-state error

load("altura.mat");
load("error.mat");

H_star = 31.0;
ta = altura(1,:);
heights = altura(3,:)*100.0;
l_a = size(heights, 2);
max_height = max(heights);

te = error(1,:);
l_e = size(te,2);
errores = error(2,:)*100.0;
ess = errores(l_e);

if max_height < H_star
    max_height = H_star;
end

disp("Peak: "+max_height);
pos = ((max_height - H_star) / H_star)*100;
disp("Percent overshoot: "+pos);
disp("Ess: "+ess);

st = settling_time(2, H_star, te, errores);
disp("Settling time " + st);

% recibe: el porcentaje, el valor de referencia, el arreglo del tiempo y el
% arreglo del error
function st = settling_time(per, ref, time, error)
    st = 0;
    per = per / 100.0;
    first_time = true;
    l_e = size(time,2);
    delta = per*ref;
    for i=1:l_e
        % si es la primera vez que entra al rango
        if abs(error(i)) <= delta && first_time
            st = time(i);
            first_time = false;
        end
        % si se sale del rango, se reinicia
        if abs(error(i)) > delta
            st = 0;
            first_time = true;
        end
    end
end

