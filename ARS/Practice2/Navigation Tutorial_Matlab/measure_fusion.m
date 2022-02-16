function [particles_UAV1, particles_UAV2, particles_SF]= measure_fusion(particles_UAV1, particles_UAV2, particles_SF)
global  Rm num_particles num_landmarks real_landmarks P0 timestep

if timestep == 1
   disp('2: Measurement Fusion') 
end

for lIdx = 1:num_landmarks
    real_landmark = real_landmarks(:, lIdx);
    
    % Take measurements from two UAVs
    
    z_real(1) = particles_UAV1(num_particles+1).landmarks(lIdx).read_distance;
    z_real(2) = particles_UAV1(num_particles+1).landmarks(lIdx).read_angle;
    z_real(3) = particles_UAV2(num_particles+1).landmarks(lIdx).read_distance;
    z_real(4) = particles_UAV2(num_particles+1).landmarks(lIdx).read_angle;
    
    for pIdx = 1:num_particles
        
        if(particles_UAV1(pIdx).landmarks(lIdx).seen == true)&&(particles_UAV2(pIdx).landmarks(lIdx).seen == true)
            
            if particles_SF(pIdx).landmarks(lIdx).seen == false
                 particles_SF(pIdx).landmarks(lIdx).pos = mean([particles_UAV1(pIdx).landmarks(lIdx).pos,particles_UAV2(pIdx).landmarks(lIdx).pos],2);
                 particles_SF(pIdx).landmarks(lIdx).P = P0;
                 
            end
            
            particles_SF(pIdx).landmarks(lIdx).seen = true;
            
            [z_p_1, H1] = Measurement(particles_UAV1(pIdx).position, particles_UAV1(pIdx).landmarks(lIdx).pos, [0;0]);
            [z_p_2, H2] = Measurement(particles_UAV2(pIdx).position, particles_UAV2(pIdx).landmarks(lIdx).pos, [0;0]);
            z_p = [z_p_1;z_p_2];
            H   = [H1;H2];
            
            residual = -1*(z_real' - z_p);
            
            %% IMPORTANT!! - ANGLE MANIPULATION ==============
            % make the absolute value of angles under 180deg
            if abs(residual(2))>pi
                residual(2) = residual(2) - 2*pi*sign(residual(2));
            end
            if abs(residual(4))>pi
                residual(4) = residual(4) - 2*pi*sign(residual(4));
            end
            
            % Calculate the Kalman gain
            S = H * particles_SF(pIdx).landmarks(lIdx).P * H' + Rm;
            K = particles_SF(pIdx).landmarks(lIdx).P * H' * inv(S);
            
            % to predict a new landmark position
            particles_SF(pIdx).landmarks(lIdx).pos = particles_SF(pIdx).landmarks(lIdx).pos + K*(residual);
            
            particles_UAV1(pIdx).landmarks(lIdx).pos = particles_SF(pIdx).landmarks(lIdx).pos;
            particles_UAV2(pIdx).landmarks(lIdx).pos = particles_SF(pIdx).landmarks(lIdx).pos;
            
            
            % Update the covariance of this landmark
            particles_SF(pIdx).landmarks(lIdx).P = (eye(size(K*H)) - K*H)*particles_SF(pIdx).landmarks(lIdx).P;

            particles_UAV1(pIdx).landmarks(lIdx).P = particles_SF(pIdx).landmarks(lIdx).P;
            particles_UAV2(pIdx).landmarks(lIdx).P = particles_SF(pIdx).landmarks(lIdx).P;
        end
    end %pIdx
    
end %landmark

