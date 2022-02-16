function particles = init_particle(real_position,real_landmarks, ID)
global num_particles

% Create the particles and initialize them all to be in the same initial
% position.
num_particles = 100;

particles = [];


for i = 1:num_particles+1
    particles(i).w = 1.0/num_particles;
    particles(i).position = real_position;
    for lIdx=1:size(real_landmarks,2)
        particles(i).landmarks(lIdx).seen = false;
        
        if i == num_particles+1
            particles(i).landmarks(lIdx).pos = real_landmarks(:,lIdx);
        end
        
    end
    particles(num_particles+1).ID = ID;
end