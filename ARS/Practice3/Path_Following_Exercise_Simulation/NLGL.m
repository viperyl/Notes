%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                           %
%   NLGL_Straight.m                         %
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

%.. Desired Path Parameters 
% Mode Switch - 1 : Straight-Line Following / 2 : Loiter
SW                      =               1 ;                 % Mode Switch [-]
% 1 : Straight-Line Following
% Waypoint
Wi                      =               [ 0, 0 ]' ;         % Initial Waypoint Position [m]
Wf                      =               [ 500, 500 ]' ;     % Final Waypoint Position [m]
% 2 : Loiter
%.. Loiter Orbit
O                       =               [ 0, 0 ]' ;         % Centre of Orbit [m]
r                       =               100 ;               % Radius of Orbit [m]

%.. Position and Velocity of Robot
% 1 : Straight-Line Following
if SW == 1
    x(1)                =               100 ;               % Initial Robot X Position [m]
    y(1)                =               0 ;                 % Initial Robot Y Position [m]
    psi(1)              =               0 * d2r ;           % Initial Robot Heading Angle [rad]
% 2 : Loiter
elseif SW == 2
    x(1)                =               125 ;               % Initial Robot X Position [m]
    y(1)                =               0 ;                 % Initial Robot Y Position [m]
    psi(1)              =               0 * d2r ;           % Initial Robot Heading Angle [rad]
end

p(:,1)                  =               [ x(1), y(1) ]' ;   % Robot Position Initialization [m]
va                      =               20 ;                % Robot Velocity [m/s]

%.. Maximum Lateral Acceleration of Robot
Rmin                    =               50 ;                % Robot Minimum Turn Radius [m]
umax                    =               va^2 / Rmin ;       % Robot Maximum Lateral Acceleration [m]

%.. Design Parameters
L                       =               100 ;               % L

%% Path Following Algorithm
i                       =               0 ;                 % Time Index
while i < 300
    i                   =               i + 1 ;
    
    %==============================================================================%
    %.. Path Following Algorithm
    
    % Step 1
    % Determine VTP, s = ( xt, yt )
    % 1 : Straight-Line Following
    if SW == 1
        Wfx_p           =               Wf(1) - x(i) ;
        Wfy_p           =               Wf(2) - y(i) ;
        
        Wix_p           =               Wi(1) - x(i) ;
        Wiy_p           =               Wi(2) - y(i) ;
        
        dWx             =               Wfx_p - Wix_p ;
        dWy             =               Wfy_p - Wiy_p ;
        dr              =               sqrt( dWx^2 + dWy^2 ) ;
        D               =               Wix_p * Wfy_p - Wfx_p * Wiy_p ;
        
        xt              =               x(i) + ( D * dWy + sign( dWy ) * dWx * sqrt( L^2 * dr^2 - D^2 ) ) / ( dr^2 ) ;
        yt              =               y(i) + ( - D * dWx + abs( dWy ) * sqrt( L^2 * dr^2 - D^2 ) ) / ( dr^2 ) ;
    % 2 : Loiter
    elseif SW == 2
        Dst             =               norm( p(:,i) - O, 2 ) ;
        
        A1              =               1 / 2 ;
        A2              =               ( L^2 - r^2 ) / ( 2 * Dst^2 ) ;
        A3              =               1 / ( 2 * Dst^2 ) * sqrt( ( ( L + r )^2 - Dst^2 ) * ( Dst^2 - ( L - r )^2 ) ) ;
        
        xt              =               A1 * ( x(i) + O(1) ) + A2 * ( O(1) - x(i) ) + A3 * ( O(2) - y(i) ) ;
        yt              =               A1 * ( y(i) + O(2) ) + A2 * ( O(2) - y(i) ) - A3 * ( O(1) - x(i) ) ;
    end
    
    % Step 2
    % Desired heading angle, theta
    theta               =                ;
    % Wrapping up theta
    theta = rem(theta,2*pi);
    if theta < -pi
        theta = theta + 2*pi;
    elseif theta > pi
        theta = theta-2*pi;
    end
    
    % Step 3
    % Desired heading angle error, nu
    eta                 =                ;
    % Wrapping up eta
    eta = rem(eta,2*pi);
    if eta < -pi
        eta = eta + 2*pi;
    elseif eta > pi
        eta = eta-2*pi;
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
% 1 : Straight-Line Following
if SW == 1
    figure(1) ;
    plot( [ Wi(1), Wf(1) ], [ Wi(2), Wf(2) ], 'r', 'LineWidth', 2 ) ;
    hold on ;
    plot( x, y, 'LineWidth', 2 ) ;
    hold on ;
    xlabel('X (m)') ;
    ylabel('Y (m)') ;
    legend('Desired Path', 'Robot Trajectory', 'Location', 'southeast' ) ;
    axis([ 0 500 0 500 ]) ;
elseif SW == 2
% 2 : Loiter
    % Parameterized Loiter Orbit
    TH                  =               0:0.01:2*pi ;
    Xc                  =               O(1) + r * cos( TH ) ;
    Yc                  =               O(2) + r * sin( TH ) ;

    figure(1) ;
    plot( Xc, Yc, 'r', 'LineWidth', 2 ) ;
    hold on ;
    plot( x, y, 'LineWidth', 2 ) ;
    hold on ;
    xlabel('X (m)') ;
    ylabel('Y (m)') ;
    legend('Desired Path', 'Robot Trajectory', 'Location', 'southeast' ) ;
    axis([ -200 200 -200 200 ]) ;
end

%.. Guidance Command
figure(2) ;
plot( t(1:end-1), u, 'LineWidth', 2 ) ;
xlabel('Time (s)') ;
ylabel('u (m/s^2)') ;