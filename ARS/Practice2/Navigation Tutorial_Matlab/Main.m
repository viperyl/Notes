clear all;
clc;
% close all;
warning off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMULATION SETTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global num_particles timestep DT

% The random number getneration
random_flag     = 0;  % on : 1 / off : 0
if random_flag == 0
    rng(190)
end

Init_filter();

% The number of timesteps for the simulation
timesteps = 100;
DT = 0.1;

% The actual positions of the landmarks and UAV
Init_pos();

% Create the particles and initialize them all to be in the same initial
% position.
particles_UAV1 = init_particle(real_pos_UAV1,real_landmarks, 1);
particles_UAV2 = init_particle(real_pos_UAV2,real_landmarks, 2);
particles_SF   = init_particle(real_pos_UAV1,real_landmarks, 0);

pos_hist_1 = [];
pos_hist_2 = [];

pos_hat_land1_history1 = [];
P_data_stack1=[];
pos_hat_history1=[];
pos_hat_land1_history2 = [];
P_data_stack2=[];
pos_hat_history2=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMULATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)

for timestep = 1:timesteps
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Move the UAV (for simulation)
    real_pos_UAV1 = Propagation(real_pos_UAV1, vel_cmd, [0,0]);
    particles_UAV1(num_particles+1).position = real_pos_UAV1;
    
    real_pos_UAV2 = Propagation(real_pos_UAV2, vel_cmd, [0,0]);
    particles_UAV2(num_particles+1).position = real_pos_UAV2;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Propagation of particles
    particles_UAV1 = fn_particle_propa(particles_UAV1);
    particles_UAV2 = fn_particle_propa(particles_UAV2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Try to take a measurement from each landmark
    particles_UAV1 = fn_landmark_update(particles_UAV1);
    particles_UAV2 = fn_landmark_update(particles_UAV2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Fusion
    % State-vector Fusion
%     [particles_UAV1, particles_UAV2, particles_SF] = state_fusion(particles_UAV1, particles_UAV2, particles_SF);
    % Measurement-level Fusion
%     [particles_UAV1, particles_UAV2, particles_SF] = measure_fusion(particles_UAV1, particles_UAV2, particles_SF);
    % Covariance Intersection
%     [particles_UAV1, particles_UAV2, particles_SF] = cov_inter_fusion(particles_UAV1, particles_UAV2, particles_SF);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % PLOTTING
    fn_plot();
    pause(.001);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Data save

    Data_Save();

    
end

%% Result plot
Err_plot();


pos_hat_land1_history = pos_hat_land1_history1;
P_data_stack          = P_data_stack1;
pos_hat_history       = pos_hat_history1;
stack_detect_flag     = stack_detect_flag1;
Performance_plot();


pos_hat_land1_history = pos_hat_land1_history2;
P_data_stack          = P_data_stack2;
pos_hat_history       = pos_hat_history2;
stack_detect_flag     = stack_detect_flag2;
Performance_plot();

