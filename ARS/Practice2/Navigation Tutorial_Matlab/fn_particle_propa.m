function particles = fn_particle_propa(particles)

global vel_cmd state_variance num_particles

% Propagation of particles
for pIdx = 1:num_particles
    particles(pIdx).position = Propagation( ...
        particles(pIdx).position, vel_cmd, state_variance);
end