
clear all;

load("error.mat");

iec = 0.0; % integral del error cuadrático
iea = 0.0; % integral del error absoluto

dt = error(1,2);

for i=1:801
    aumento = abs(error(2,i))*100*dt;
    iea = iea + aumento;
    iec = iec + aumento^2;
end

disp(iea);
disp(iec);
