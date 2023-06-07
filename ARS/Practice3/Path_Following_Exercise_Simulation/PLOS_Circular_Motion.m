%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                           %
%   PLOS_Circular_Motion.m                  %
%                                           %
%                                           %
%                 Created by Min-Guk Seo    %
%                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear all ;
close all ;
clc ;

%% Parameters
%.. Angle Converting Parameters
r2d                     =               180 / pi ;          % Radian to Degree [-]
d2r                     =               1 / r2d ;           % Degree to Radian [-]

%.. Time Step Size
dt                      =               0.1 ;               % Time Step Size [s]

%.. Time
t(1)                    =               0 ;                 % Simulation Time [s]

%.. Circular Orbit
O                       =               [ 0, 0 ]' ;         % Centre of Orbit [m]
r                       =               100 ;               % Radius of Orbit [m]

%.. Position and Velocity of Robot
x(1)                    =               125 ;               % Initial Robot X Position [m]
y(1)                    =               0 ;                 % Initial Robot Y Position [m]
psi(1)                  =               0 * d2r ;           % Initial Robot Heading Angle [rad]

p(:,1)                  =               [ x(1), y(1) ]' ;   % Robot Position Initialization [m]
va                      =               20 ;                % Robot Velocity [m/s]

%.. Maximum Lateral Acceleration of Robot
Rmin                    =               50 ;                % Robot Minimum Turn Radius [m]
umax                    =               va^2 / Rmin ;       % Robot Maximum Lateral Acceleration [m]

%.. Design Parameters
k1                      =               5 ;                 % k1
k2                      =               0.05 ;              % k2

%% Path Following Algorithm
i                       =               0 ;                 % Time Index
while i<5000
    i                   =               i + 1 ;
    
    %==============================================================================%
    %.. Path Following Algorithm
    
    % Step 1
    % Distance between orbit and current Robot position, d
    d                   =                ;
    
    % Step 2
    % Orientation of vector from initial waypoint to final waypoint, theta
    theta               =                ;
    
    % Step 3
    % Desired heading angle, thetap
    thetap              =                ;
    % Heading angle error, DEL_psi
    DEL_psi             =                ;
    % Wrapping up thetap
    DEL_psi             =               rem(DEL_psi,2*pi);
    if DEL_psi < - pi
        DEL_psi = DEL_psi + 2*pi;
    elseif DEL_psi > pi
        DEL_psi = DEL_psi - 2*pi;
    end
    
    % Step 4
    % Desired heading angle rate, psid
    psi_dot             =                ;
    
    % Step 5
    % Guidance command, u
    u(i)                =                ;
    % Limit u
    if u(i) > umax
        u(i)            =               umax;
    elseif u(i) < -umax
        u(i)            =             - umax;
    end
    %==============================================================================%
    
    %.. Robot Dynamics
    % Dynamic Model of Robot
    dx                  =               va * cos( psi(i) ) ;
    dy                  =               va * sin( psi(i) ) ;
    dpsi                =               u(i) / va ;
    
    % Robot State Update
    x(i+1)              =               x(i) + dx * dt ;
    y(i+1)              =               y(i) + dy * dt ;
    psi(i+1)            =               psi(i) + dpsi * dt ;
    
    % Robot Position Vector Update
    p(:,i+1)            =               [ x(i+1), y(i+1) ]' ;
    
    %.. Time Update
    t(i+1)              =               t(i) + dt ;
end

%% Result Plot
% Parameterized Circular Orbit
TH                      =               0:0.01:2*pi ;
Xc                      =               O(1) + r * cos( TH ) ;
Yc                      =               O(2) + r * sin( TH ) ;

%.. Trajectory Plot
figure(1) ;
plot( Xc, Yc, 'r', 'LineWidth', 2 ) ;
hold on ;
plot( x, y, 'LineWidth', 2 ) ;
hold on ;
xlabel('X (m)') ;
ylabel('Y (m)') ;
legend('Desired Path', 'Robot Trajectory', 'Location', 'southeast' ) ;
axis([ -200 200 -200 200 ]) ;

%.. Guidance Command
figure(2) ;
plot( t(1:end-1), u, 'LineWidth', 2 ) ;
xlabel('Time (s)') ;
ylabel('u (m/s^2)') ;