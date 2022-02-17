%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                           %
%   CCA_Straight.m                          %
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

%.. Waypoint
Wi                      =               [ 0, 0 ]' ;         % Initial Waypoint Position [m]
Wf                      =               [ 500, 500 ]' ;     % Final Waypoint Position [m]

%.. Position and Velocity of Robot
x(1)                    =               100 ;               % Initial Robot X Position [m]
y(1)                    =               0 ;                 % Initial Robot Y Position [m]
psi(1)                  =               0 * d2r ;           % Initial Robot Heading Angle [rad]

p(:,1)                  =               [ x(1), y(1) ]' ;   % Robot Position Initialization [m]
va                      =               20 ;                % Robot Velocity [m/s]

%.. Maximum Lateral Acceleration of Robot
Rmin                    =               50 ;                % Robot Minimum Turn Radius [m]
umax                    =               va^2 / Rmin ;       % Robot Maximum Lateral Acceleration [m]

%.. Design Parameters
kappa                   =               0.75 ;              % Gain
delta                   =               0 ;                 % Carrot Distance

%% Path Following Algorithm
i                       =               0 ;                 % Time Index
while x(i+1)<500
    i                   =               i + 1 ;
    
    %==============================================================================%
    %.. Path Following Algorithm
    
    % Step 1
    % Distance between initial waypoint and current Robot position, Ru
    Ru                  =                ;    
    % Orientation of vector from initial waypoint to final waypoint, theta
    theta               =                ;
    
    % Step 2
    % Orientation of vector from initial waypoint to current Robot position, thetau
    thetau              =                ;
    % Difference between theta and theatu, DEL_theta
    DEL_theta           =                ;
    
    % Step 3
    % Distance between initial waypoint and q, R
    R                   =                ;
    
    % Step 4
    % Carrot position, s = ( xt, yt )
    xt                  =                ;
    yt                  =                ;
    
    % Step 5
    % Desired heading angle, psid
    psid                =                ;
    % Wrapping up psid
    psid = rem(psid,2*pi);
    if psid < -pi
        psid = psid + 2*pi;
    elseif psid > pi
        psid = psid-2*pi;
    end
    
    % Step6
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
%.. Trajectory Plot
figure(1) ;
plot( [ Wi(1), Wf(1) ], [ Wi(2), Wf(2) ], 'r', 'LineWidth', 2 ) ;
hold on ;
plot( x, y, 'LineWidth', 2 ) ;
hold on ;
xlabel('X (m)') ;
ylabel('Y (m)') ;
legend('Desired Path', 'Robot Trajectory', 'Location', 'southeast' ) ;
axis([ 0 500 0 500 ]) ;

%.. Guidance Command
figure(2) ;
plot( t(1:end-1), u, 'LineWidth', 2 ) ;
xlabel('Time (s)') ;
ylabel('u (m/s^2)') ;