% The actual positions of the landmarks (each column is a separate landmark)
global max_read_distance temp_c real_landmarks vel_cmd num_landmarks

num_landmarks = 30;

real_landmarks = [randi(50,1,num_landmarks)-25;      % x
                  randi(50,1,num_landmarks)-25];     % y

% The initial starting position of the UAV
real_pos_UAV1 = [-10.0;      % x
                 20.0;     % y
                 300*pi/180];  % rotation

real_pos_UAV2 = [-20.0;      % x
                 5.0;     % y
                 310*pi/180];  % rotation

             
% The movement command given of UAV at each timestep
vel_cmd          = [5;     % Distance
                    .1];   % Rotation
             
             
% The field of range of our sensor (can sense a landmark)
max_read_distance = 12;

for loop = 1:11
    theta = 360/10;
    temp_c(loop,1) = max_read_distance*cosd(36*loop);
    temp_c(loop,2) = max_read_distance*sind(36*loop);
end
