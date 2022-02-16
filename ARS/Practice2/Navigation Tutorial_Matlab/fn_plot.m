
% true data save
pos_hist_1 = [pos_hist_1, real_pos_UAV1];
pos_hist_2 = [pos_hist_2, real_pos_UAV2];

% plotting
clf;
[particles_UAV1,~] = sub_plot(particles_UAV1,pos_hist_1);
[particles_UAV2,p] = sub_plot(particles_UAV2,pos_hist_2);
%
for lIdx = 1:size(real_landmarks,2)
    if(particles_SF(1).landmarks(lIdx).seen)
        avg_landmark_guess =[0;0];
        for pIdx = 1:num_particles
            avg_landmark_guess = avg_landmark_guess + particles_SF(pIdx).landmarks(lIdx).pos;
        end
        avg_landmark_guess = avg_landmark_guess / num_particles;
        p(7)=plot(avg_landmark_guess(1), avg_landmark_guess(2), 'rsq');
    end
end

grid on;

if size(p,2)>6
    
    legend(p,{'True Landmark','Estimated Landmark','Paticles','Mean of Particles','True position','FOR','Fused Landmark'})
else
    legend(p,{'True Landmark','Estimated Landmark','Paticles','Mean of Particles','True position','FOR'})
end