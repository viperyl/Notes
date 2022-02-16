%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data Save
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temp_pos_1=[];
temp_pos_land1_1=[];

temp_pos_2=[];
temp_pos_land1_2=[];

% obs_land_num = 3;




%% landmark position error from UAV1
for k = 1:num_particles
    temp_pos_1        = [temp_pos_1, particles_UAV1(k).position];
end

for loop_land = 1 : size(real_landmarks,2)
    temp_pos_land1_1=[];
    temp=[];
    
    stack_detect_flag1(timestep,loop_land) = particles_UAV1(1).landmarks(loop_land).seen;
    
    for obs_p_num = 1:num_particles
        if ~isempty(particles_UAV1(obs_p_num).landmarks(loop_land).pos)
            temp_pos_land1_1  = [temp_pos_land1_1, particles_UAV1(obs_p_num).landmarks(loop_land).pos];
            temp=[temp,[particles_UAV1(obs_p_num).landmarks(loop_land).P(1,1);particles_UAV1(obs_p_num).landmarks(loop_land).P(2,2)]];
        else
            temp_pos_land1_1  = [0;0];
            temp=[temp,[P0(1,1);P0(2,2)]];
        end
    end
    mean_land_pos1(:,loop_land) = mean(temp_pos_land1_1,2);
    mean_land_cov1(:,loop_land) = mean(temp,2);
end

%% landmark position error from UAV2


for k = 1:num_particles
    temp_pos_2        = [temp_pos_2, particles_UAV1(k).position];
end

for loop_land = 1 : num_landmarks
    temp_pos_land1_2=[];
    temp=[];
    
    stack_detect_flag2(timestep,loop_land) = particles_UAV2(1).landmarks(loop_land).seen;

    
    for obs_p_num = 1:num_particles
        if ~isempty(particles_UAV2(obs_p_num).landmarks(loop_land).pos)
            temp_pos_land1_2  = [temp_pos_land1_2, particles_UAV2(obs_p_num).landmarks(loop_land).pos];
            temp=[temp,[particles_UAV2(obs_p_num).landmarks(loop_land).P(1,1);particles_UAV2(obs_p_num).landmarks(loop_land).P(2,2)]];
        else
            temp_pos_land1_2  = [0;0];
            temp=[temp,[P0(1,1);P0(2,2)]];
        end
    end
    mean_land_pos2(:,loop_land) = mean(temp_pos_land1_2,2);
    mean_land_cov2(:,loop_land) = mean(temp,2);
end

% UAV position error
avg_uav1_guess =[0;0;0];
for pIdx = 1:num_particles
    avg_uav1_guess = avg_uav1_guess + particles_UAV1(pIdx).position;
end
avg_uav1_guess = avg_uav1_guess / num_particles;

est_pos_uav1(timestep,1:3)  = avg_uav1_guess';
real_pos_uav1(timestep,1:3) = real_pos_UAV1';

avg_uav2_guess =[0;0;0];
for pIdx = 1:num_particles
    avg_uav2_guess = avg_uav2_guess + particles_UAV2(pIdx).position;
end
avg_uav2_guess = avg_uav2_guess / num_particles;

est_pos_uav2(timestep,1:3)  = avg_uav2_guess';
real_pos_uav2(timestep,1:3) = real_pos_UAV2';


pos_hat_land1_history1 = [pos_hat_land1_history1, reshape(mean_land_pos1,num_landmarks*2,1)];
P_data_stack1          = [P_data_stack1,reshape(mean_land_cov1,num_landmarks*2,1)];
pos_hat_history1 = [pos_hat_history1, mean(temp_pos_1,2)];


pos_hat_land1_history2 = [pos_hat_land1_history2, reshape(mean_land_pos2,num_landmarks*2,1)];
P_data_stack2          = [P_data_stack2,reshape(mean_land_cov2,num_landmarks*2,1)];
pos_hat_history2 = [pos_hat_history2, mean(temp_pos_1,2)];