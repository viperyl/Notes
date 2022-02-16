function [particles_UAV1, particles_UAV2, particles_SF] = cov_inter_fusion(particles_UAV1, particles_UAV2, particles_SF)
global num_landmarks num_particles timestep

if timestep == 1
   disp('3: Covariance Intersection') 
end

% Covariance Intersection Fusion
for lIdx = 1:num_landmarks
    for pIdx = 1:num_particles
        
        if(particles_UAV1(pIdx).landmarks(lIdx).seen == true)&&(particles_UAV2(pIdx).landmarks(lIdx).seen == true)
            particles_SF(pIdx).landmarks(lIdx).seen = true;
            
            
            a = particles_UAV1(pIdx).landmarks(lIdx).pos;
            b = particles_UAV2(pIdx).landmarks(lIdx).pos;
            A = particles_UAV1(pIdx).landmarks(lIdx).P;
            B = particles_UAV2(pIdx).landmarks(lIdx).P;
            
            inv_A = inv( A );
            inv_B = inv( B );
            omega = omega_value(inv_A,inv_B);
            particles_SF(pIdx).landmarks(lIdx).P = inv( omega*inv_A + (1-omega)*inv_B );
            particles_SF(pIdx).landmarks(lIdx).pos = particles_SF(pIdx).landmarks(lIdx).P*( omega*inv_A*a+(1-omega)*inv_B*b );

            particles_UAV1(pIdx).landmarks(lIdx).P=particles_SF(pIdx).landmarks(lIdx).P;
            particles_UAV1(pIdx).landmarks(lIdx).pos=particles_SF(pIdx).landmarks(lIdx).pos;
            particles_UAV2(pIdx).landmarks(lIdx).P=particles_SF(pIdx).landmarks(lIdx).P;
            particles_UAV2(pIdx).landmarks(lIdx).pos=particles_SF(pIdx).landmarks(lIdx).pos;
            
        end
        
    end
end