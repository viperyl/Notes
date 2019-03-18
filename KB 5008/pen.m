clc,clear
close all


y0 = [20*pi/180;0;20*pi/180;0];

[t,y] = ode23s(@vdp1,[0,50],y0);


%plot(y(:,1),y(:,3))
plot(t,y(:,1),t,y(:,3))
%plot(y(:,1),y(:,3))

function dydt = vdp1(t,th)
m1 = 0.174;
m2 = 0.174;
l1 = 0.38;
l2 = 0.38;
a1 = 0.30;
a2 = 0.30;
k = 1.4526;
w = 0.35;
H = 0.1436;
W = 0.0709;
g = 9.8;

Izz1 = (1/12) * m1 * (H^2 + W^2) + m1 * l1^2;
Izz2 = (1/12) * m2 * (H^2 + W^2) + m2 * l2^2;

c = w - a1 * sin(th(1)) + a2 * sin(th(3));
d = 0 + a1 * cos(th(1)) - a2 * cos(th(3));

x = sqrt(c^2 + d^2);

alpha1 = atan2(d,c) + th(1);
alpha2 = atan2(d,c) + th(3);

dydt = [th(2);
    (-1/Izz1) * (a1 * k * x * cos(alpha1) + m1 * g * l1 * sin(th(1)));
    th(4);
    (+1/Izz2) * (a2 * k * x * cos(alpha2) - m2 * g * l2 * sin(th(3)))];
end



