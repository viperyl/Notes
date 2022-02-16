function [particles]= fn_landmark_update(particles)

global max_read_distance measurement_variance R P0 num_particles real_landmarks

real_position = particles(num_particles+1).position;

doResample = false;
for lIdx = 1:size(real_landmarks,2)
    real_landmark = real_landmarks(:, lIdx);
    
    % Take a real (noisy) measurement from the UAV to the landmark
    [z_real, G] = Measurement(real_position, real_landmark, measurement_variance);
    
    particles(num_particles+1).landmarks(lIdx).read_distance = z_real(1);
    particles(num_particles+1).landmarks(lIdx).read_angle = z_real(2);
    
    read_distance(lIdx) = z_real(1);
    read_angle(lIdx)    = z_real(2);
    
    % If the landmark is close enough, then we can spot it
    if(read_distance(lIdx) < max_read_distance)
        doResample = true;
        
        for pIdx = 1:num_particles
            
            if(particles(pIdx).landmarks(lIdx).seen == false)
                
                % If we have never seen this landmark, then we need to initialize it.
                % We'll just use whatever first measurement we recieved.
                particles(pIdx).landmarks(lIdx).pos = [particles(pIdx).position(1) + cos(read_angle(lIdx))*read_distance(lIdx);
                    particles(pIdx).position(2) + sin(read_angle(lIdx))*read_distance(lIdx) ];
                % Initialize the position covariance
                particles(pIdx).landmarks(lIdx).P = P0;
                particles(pIdx).landmarks(lIdx).seen = true;
                
            else
                [z_p, ~] = Measurement(particles(pIdx).position, particles(pIdx).landmarks(lIdx).pos, [0;0]);
                residual = z_real - z_p;
                %% IMPORTANT!! - ANGLE MANIPULATION ==============
                % make the absolute value of angles under 180deg
                if abs(residual(2))>pi
                    residual(2) = residual(2) - 2*pi*sign(residual(2));
                end
                
                % Calculate the Kalman gain
                S = G * particles(pIdx).landmarks(lIdx).P * G' + R;
                K = particles(pIdx).landmarks(lIdx).P * G' * inv(S);
                
                % to predict a new landmark position
                particles(pIdx).landmarks(lIdx).pos = particles(pIdx).landmarks(lIdx).pos + K*(residual);
                
                % Update the covariance of this landmark
                particles(pIdx).landmarks(lIdx).P = (eye(2) - K*G)*particles(pIdx).landmarks(lIdx).P;
                
                % Update the weight of the particle
                particles(pIdx).w = ;
            end
        end %pIdx
    end %distance
end %landmark


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Try to take a measurement from each landmark

% Resample all particles based on their weights
if(doResample)
    particles_new        = resample(particles(1,1:end-1));
    particles(1,1:end-1) = particles_new;
end



