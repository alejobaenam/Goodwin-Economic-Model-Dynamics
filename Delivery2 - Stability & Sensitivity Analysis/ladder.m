function [t,u,Nh,Nw,tmax] = ladder(h,Tw,Ts)
% [t,u,Nh,Nw,tmax] = ladder(h,Tw,Ts)
% h     Vector con las alturas de cada escalón
% Tw    Ancho de cada escalón
% Ts    Período de muestreo
% t     Vector de tiempo
% u     Vector de la señal escalera
% Nh    Número de escalones
% Nw    Número de muestras en cada cada escalón
% tmax  Tiempo máximo

Nh = length(h);
t = (0:Ts:Tw*Nh)'; % Vector de tiempo de la simulación
tmax = t(end);
tmax = t(end);
N = length(t); % Número de puntos de la entrada
Nw = Tw/Ts;
u = zeros(N,1);
for i = 1:Nh
    u((i-1)*Nw+1:i*Nw) = h(i)*ones(Nw,1);
end
u(N) = h(Nh); 
end