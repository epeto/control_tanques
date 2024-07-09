
% Se calculan las medidas de desempeño: Overshoot, Settling time,
% Steady-state error

load("altura.mat");
load("error.mat");

H_star1 = 40.0;
H_star2 = 15.0;
ta = altura(1,:); % tiempo del vector de alturas
h1 = altura(4,:)*100.0; % medidas de alturas para tanque 1
l_a = size(h1, 2);
max_height1 = max(h1);
h2 = altura(6,:)*100; % medidas de alturas para tanque 2
max_height2 = max(h2);

te = error(1,:);
l_e = size(te,2);
error1 = error(2,:)*100;
ess1 = error1(l_e);
error2 = error(3,:)*100;
ess2 = error2(l_e);

if max_height1 < H_star1
    max_height1 = H_star1;
end

if max_height2 < H_star2
    max_height2 = H_star2;
end

disp("Peak1: "+max_height1);
pos1 = ((max_height1 - H_star1) / H_star1)*100;
disp("Percent overshoot1: "+pos1);
disp("Ess1: "+ess1);

st1 = settling_time(2, H_star1, te, error1);
disp("Settling time1 " + st1);

disp("Peak2: "+max_height2);
pos2 = ((max_height2 - H_star2) / H_star2)*100;
disp("Percent overshoot1: "+pos2);
disp("Ess1: "+ess2);

st2 = settling_time(2, H_star2, te, error2);
disp("Settling time2 " + st2);

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

