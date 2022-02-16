function [particles_UAV1, particles_UAV2, particles_SF] = state_fusion(particles_UAV1, particles_UAV2, particles_SF)
global num_landmarks num_particles timestep

if timestep == 1
   disp('1: State-vector Fusion') 
end

% State-vector Fusion
for lIdx = 1:num_landmarks
    for pIdx = 1:num_particles
        
        if(particles_UAV1(pIdx).landmarks(lIdx).seen == true)&&(particles_UAV2(pIdx).landmarks(lIdx).seen == true)
            particles_SF(pIdx).landmarks(lIdx).seen = true;
            
            a = particles_UAV1(pIdx).landmarks(lIdx).pos;
            b = particles_UAV2(pIdx).landmarks(lIdx).pos;
            A = particles_UAV1(pIdx).landmarks(lIdx).P;
            B = particles_UAV2(pIdx).landmarks(lIdx).P;
            particles_SF(pIdx).landmarks(lIdx).P   = A-A*inv(A+B)*A';
            particles_SF(pIdx).landmarks(lIdx).pos = a+A*inv(A+B)*(b-a);
            
            particles_UAV1(pIdx).landmarks(lIdx).P=particles_SF(pIdx).landmarks(lIdx).P;
            particles_UAV1(pIdx).landmarks(lIdx).pos=particles_SF(pIdx).landmarks(lIdx).pos;
            particles_UAV2(pIdx).landmarks(lIdx).P=particles_SF(pIdx).landmarks(lIdx).P;
            particles_UAV2(pIdx).landmarks(lIdx).pos=particles_SF(pIdx).landmarks(lIdx).pos;
        end
        
    end
end