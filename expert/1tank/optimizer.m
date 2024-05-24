
clear global;

[error_glob, error_acum, k1_best, k2_best, time] = getMinK(50000);
disp("Error acum:"+error_acum);
disp("k1:"+k1_best);
disp("k2:"+k2_best);
ceros = zeros(size(time));
figure(1)
plot(time, ceros, 'b', time, error_glob, 'r', 'linewidth', 2);
xlabel('time (s)');
ylabel('error');

function [error, error_acum, time] = simulacion(k1, k2)
    A1 = 0.0154;
    A2 = 5e-5;
    az = 1;
    H_max = 0.62;
    g = 9.8;
    ro = 1000;
    Qmax = 0.5;
    Qmin = 0;
    H_star = H_max/2;
    Q_star = ro*A2*az*sqrt(2*g*H_star);
    num1 = 1/(ro*A1);
    den1 = 1;
    den2 = ((az*A2)^2*g*ro)/(A1*Q_star);

    ts=0.1; % periodo
    sys = tf(num1,[den1,den2]); %Planta
    dsys=c2d(sys,ts); % planta discretizada
    [num,den]=tfdata(dsys,'v');

    kp = 1.06160;
    ki = 0.03014;
    kd = -2.20023;

    M1 = H_max/3;
    M2 = H_max/6;
    epsilon = 0.01;
    ei = 0;

    tiempo_total = 300;
    sz = tiempo_total/ts; %número de iteraciones
    time = zeros(1,sz);
    yd = zeros(1,sz);
    y = zeros(1,sz);
    error = zeros(1,sz);
    derror = zeros(1,sz);
    u = zeros(1,sz);

    error(1) = H_star;
    error(2) = H_star;
    yd(1) = H_star;
    yd(2) = H_star;
    y(1) = 0;
    y(2) = 0;
    time(2) = ts;
    error_acum = 0;
    for i = 3:sz
        time(i) = i*ts;
        yd(i) = H_star;
        y(i) = -den(2)*y(i-1) + num(2)*u(i-1);
        error(i)=yd(i)-y(i); % Proporcional
        error_acum = error_acum + abs(error(i));
        derror(i)=error(i)-error(i-1); % Derivativo
        ei=ei+error(i)*ts; % Integral
        aplicar_regla = 0;
        % Primer paso: elección de la regla
        if abs(error(i)) > M1
            aplicar_regla = 1;
            if error(i) > 0
                u(i) = Qmax*0.5;
            else
                u(i) = Qmin;
            end
        elseif abs(error(i)) <= epsilon
            aplicar_regla = 5;
            u(i) = u(i-1) + kp*(error(i) - error(i-1)) + ki*ei;
        elseif error(i)*derror(i) < 0 && derror(i)*derror(i-1) < 0
            aplicar_regla = 4;
            if abs(error(i)) >= M2
                u(i) = u(i-1) + k1*kp*error(i);
            else
                u(i) = u(i-1) + k2*kp*error(i);
            end
        elseif (error(i)*derror(i) < 0 && derror(i)*derror(i-1) > 0) || error(i) == 0
            aplicar_regla = 3;
            u(i) = u(i-1);
        elseif error(i)*derror(i) > 0 || derror(i) == 0
            aplicar_regla = 2;
            if abs(error(i)) >= M2
                %control fuerte
                u(i) = u(i-1) + k1*kp*(error(i) - error(i-1)) + k1*ki*error(i) + k1*kd*(error(i) - 2*error(i-1) + error(i-2));
            else
                %control débil
                u(i) = u(i-1) + kp*(error(i) - error(i-1)) + ki*error(i) + kd*(error(i) - 2*error(i-1) + error(i-2));
            end
        else
            aplicar_regla = 0;
            u(i)=kp*error(i) + (kd*derror(i))/ts + ki*ei;
        end
    end
end

function [error_glob, error_acum, k1_best, k2_best, time] = getMinK(iters)
    error_acum = inf;
    k1_best = 0;
    k2_best = 0;
    tiempo_total = 300;
    ts=0.1; % periodo
    sz = tiempo_total/ts; %número de iteraciones
    time = zeros(1,sz);
    error_glob = zeros(1,sz);
    for i = 1:iters
        k1 = rand*9 + 1;
        k2 = rand;
        [error, ea, time] = simulacion(k1, k2);
        if ea < error_acum
            error_glob = error;
            error_acum = ea;
            k1_best = k1;
            k2_best = k2;
        end
    end
end
