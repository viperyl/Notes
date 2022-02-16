% Initialization of filter
global measurement_variance R Rm P0 state_variance

% The Gaussian variance of the system
state_variance = [3;   % Distance
                  3]; % Rotation
Q = diag([state_variance(1),state_variance(1),state_variance(2)]);

% The Gaussian variance of the meausrement
measurement_variance = [1;     % Distance
                        0.01];   % Angle
R = diag([measurement_variance(1),measurement_variance(2)]);

% The inital coveriacne
P0  =  diag([0.01 0.01]);

Rm = diag([measurement_variance(1),measurement_variance(2),measurement_variance(1),measurement_variance(2)]);