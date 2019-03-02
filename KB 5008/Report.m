clc,clear
close all

% Necessary parameters
x_0 = 10;
L_2 = 15;
L_1 = 10;
a_2 = 3;
a_1 = 6;
L_k = 10;
K = 20;         % N/m
G = 9.8;        % m/s^2
m1 = 1;         % kg
m2 = 1;         % kg
theta2 =    90*pi/180;
theta1 =    90*pi/180;
alpha_2 =   90*pi/180;
alpha_1 =   90*pi/180;


% Necessary func
nv = @(th) [cos(th),sin(th)];
L = @(th1,th2) sqrt((x_0^2+a_1*(sin(th1)-sin(th2))^2)+(a_2^2*(cos(th2)-cos(th1)^2)));
nvv = @(x4,x3,y3,y4,th1,th2) [x4-x3,y4-y3]*1/L(th1,th2);
f_theta_1 = @(x3,y3,x4,y4,th1,th2) dot(nv(th2),nvv(x4,x3,y3,y4,th1,th2))*K*(1-2*L_k/L(th1,th2));
f_theta_2 = @(x3,y3,x4,y4,th1,th2) dot(nv(th1),nvv(x4,x3,y3,y4,th1,th2))*K*(1-2*L_k/L(th1,th2));
X_1 = @(th) -x_0 + L_2 * sin(th);
X_2 = @(th)  x_0 + L_1 * sin(th);
X_3 = @(th) -x_0 + a_2 * sin(th);
X_4 = @(th)  x_0 + a_1 * sin(th);
Y_1 = @(th) -L_2 * cos(th);
Y_2 = @(th) -L_1 * cos(th);
Y_3 = @(th) -a_2 * cos(th);
Y_4 = @(th) -a_2 * cos(th);


% Initial data struct
t = 0:0.001:1000;
data.x_1 = zeros(1,size(t,2));
data.y_1 = zeros(1,size(t,2));
data.x_2 = zeros(1,size(t,2));
data.y_2 = zeros(1,size(t,2));
data.x_3 = zeros(1,size(t,2));
data.y_3 = zeros(1,size(t,2));
data.x_4 = zeros(1,size(t,2));
data.y_4 = zeros(1,size(t,2));
data.a_1 = zeros(1,size(t,2));
data.a_2 = zeros(1,size(t,2));

% Initial parameters
data.x_1(1) = X_1(alpha_2);
data.x_2(1) = X_2(alpha_1);
data.x_3(1) = X_3(alpha_2);
data.x_4(1) = X_4(alpha_1);
data.y_1(1) = Y_1(alpha_2);
data.y_2(1) = Y_2(alpha_1);
data.y_3(1) = Y_3(alpha_2);
data.y_4(1) = Y_4(alpha_1);
th1 = theta1;
th2 = theta2;
for i = 1:size(t,2)
    f1 = f_theta_1(data.x_3(i),data.y_3(i),data.x_4(i),data.y_4(i),th1,th2);
    f2 = f_theta_2(data.x_3(i),data.y_3(i),data.x_4(i),data.y_4(i),th1,th2);
    dydt = [y(2); (1-y(1)^2)*y(2)-y(1)];
    
    
end





