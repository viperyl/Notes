%% Estimation error
xe_anal_sf =[];

for lIdx = 1:num_landmarks
    if(particles_UAV1(1).landmarks(lIdx).seen)
        avg_landmark_guess =[0;0];
        for pIdx = 1:num_particles
            avg_landmark_guess = avg_landmark_guess + particles_UAV1(pIdx).landmarks(lIdx).pos;
        end
        avg_landmark_guess = avg_landmark_guess / num_particles;
        landmark_est_1(:,lIdx) = avg_landmark_guess;
        xe_anal_1(:,lIdx) = norm(landmark_est_1(1,lIdx)-real_landmarks(1,lIdx));
        ye_anal_1(:,lIdx) = norm(landmark_est_1(2,lIdx)-real_landmarks(2,lIdx));
    end
    
    if(particles_UAV2(1).landmarks(lIdx).seen)
        avg_landmark_guess =[0;0];
        for pIdx = 1:num_particles
            avg_landmark_guess = avg_landmark_guess + particles_UAV2(pIdx).landmarks(lIdx).pos;
        end
        avg_landmark_guess = avg_landmark_guess / num_particles;
        landmark_est_2(:,lIdx) = avg_landmark_guess;
        xe_anal_2(:,lIdx) = norm(landmark_est_2(1,lIdx)-real_landmarks(1,lIdx));
        ye_anal_2(:,lIdx) = norm(landmark_est_2(2,lIdx)-real_landmarks(2,lIdx));
    end
    
    if(particles_SF(1).landmarks(lIdx).seen)
        avg_landmark_guess =[0;0];
        for pIdx = 1:num_particles
            avg_landmark_guess = avg_landmark_guess + particles_SF(pIdx).landmarks(lIdx).pos;
        end
        avg_landmark_guess = avg_landmark_guess / num_particles;
        landmark_est_sf(:,lIdx) = avg_landmark_guess;
        xe_anal_sf(:,lIdx) = norm(landmark_est_sf(1,lIdx)-real_landmarks(1,lIdx));
        ye_anal_sf(:,lIdx) = norm(landmark_est_sf(2,lIdx)-real_landmarks(2,lIdx));
    end
end

xe_mean_1 = mean(nonzeros(xe_anal_1));
ye_mean_1 = mean(nonzeros(ye_anal_1));

xe_mean_2 = mean(nonzeros(xe_anal_2));
ye_mean_2 = mean(nonzeros(ye_anal_2));

disp(['LM Estimation error From UAV1 [x, y, dist]:',num2str([xe_mean_1 ye_mean_1 norm([xe_mean_1 ye_mean_1])])])
disp(['LM Estimation error From UAV2 [x, y, dist]:',num2str([xe_mean_2 ye_mean_2 norm([xe_mean_2 ye_mean_2])])])
if(~isempty(xe_anal_sf))
    xe_mean_sf = mean(nonzeros(xe_anal_sf));
    ye_mean_sf = mean(nonzeros(ye_anal_sf));
    disp(['LM Estimation error From SF   [x, y, dist]:',num2str([xe_mean_sf ye_mean_sf norm([xe_mean_sf ye_mean_sf])])])
else
    xe_mean = mean([xe_mean_1 xe_mean_2]);
    ye_mean = mean([ye_mean_1 ye_mean_2]);
    disp(['LM Estimation error mean      [x, y, dist]:',num2str([xe_mean ye_mean norm([xe_mean ye_mean])])])
end

%%

Time = 1:timesteps;

figure
plot(est_pos_uav1(1:end,1), est_pos_uav1(1:end,2)); hold on;
plot(real_pos_uav1(1:end,1), real_pos_uav1(1:end,2)); grid on;
legend('Estimation','Real')
title('Trajectory of UAV1')
axis equal
figure
plot(est_pos_uav2(1:end,1), est_pos_uav2(1:end,2)); hold on;
plot(real_pos_uav2(1:end,1), real_pos_uav2(1:end,2)); grid on;
legend('Estimation','Real')
title('Trajectory of UAV2')
axis equal

figure;
subplot(411)
plot(Time(1:end)',[est_pos_uav1(1:end,1)-real_pos_uav1(1:end,1)])
title('Position error UAV1'); ylabel('X error [m]'); grid on;
subplot(412)
plot(Time(1:end)',[est_pos_uav1(1:end,2)-real_pos_uav1(1:end,2)])
title('Position error UAV1'); ylabel('Y error [m]'); grid on;
subplot(413)
plot(Time(1:end)',[est_pos_uav2(1:end,1)-real_pos_uav2(1:end,1)])
title('Position error UAV2'); ylabel('X error [m]'); grid on;
subplot(414)
plot(Time(1:end)',[est_pos_uav2(1:end,2)-real_pos_uav2(1:end,2)])
title('Position error UAV2'); ylabel('Y error [m]'); grid on;

est_err_1_x = mean(est_pos_uav1(1:end,1)-real_pos_uav1(1:end,1));
est_err_1_y = mean(est_pos_uav1(1:end,2)-real_pos_uav1(1:end,2));

est_err_2_x = mean(est_pos_uav2(1:end,1)-real_pos_uav2(1:end,1));
est_err_2_y = mean(est_pos_uav2(1:end,2)-real_pos_uav2(1:end,2));


disp(['Position Estimation error : UAV1 [x, y, dist]:',num2str([est_err_1_x est_err_1_y norm([est_err_1_x est_err_1_y])])])
disp(['Position Estimation error : UAV2 [x, y, dist]:',num2str([est_err_2_x est_err_2_y norm([est_err_2_x est_err_2_y])])])