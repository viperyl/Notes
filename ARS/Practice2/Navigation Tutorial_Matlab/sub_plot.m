%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOTTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [particles,p] = sub_plot(particles,pos_history)
global real_landmarks temp_c max_read_distance num_particles
hold on;

real_position = particles(num_particles+1).position;
ID = particles(num_particles+1).ID;

% Plot the landmarks
for lIdx=1:size(real_landmarks,2)
    read_distance(:,lIdx) = particles(num_particles+1).landmarks(lIdx).read_distance;
    read_angle(:,lIdx) = particles(num_particles+1).landmarks(lIdx).read_angle;
    p(1)=plot(real_landmarks(1,lIdx), real_landmarks(2,lIdx), 'b*');
end

for lIdx = 1:size(real_landmarks,2)
    if(particles(1).landmarks(lIdx).seen)
        avg_landmark_guess =[0;0];
        for pIdx = 1:length(particles)
            avg_landmark_guess = avg_landmark_guess + particles(pIdx).landmarks(lIdx).pos;
        end
        avg_landmark_guess = avg_landmark_guess / length(particles);
        p(2)=plot(avg_landmark_guess(1), avg_landmark_guess(2), 'ko');
    end
end

% Plot the particles
particles_pos = [particles.position];
p(3)=plot(particles_pos(1,:), particles_pos(2,:), 'r.');
p(4)=plot(mean(particles_pos(1,:)), mean(particles_pos(2,:)), 'ro','MarkerSize',15);

% Plot the real UAV
plot(pos_history(1,:), pos_history(2,:), 'r');

text(pos_history(1,1),pos_history(2,1),['UAV',num2str(ID)])

w = .1;
l = .3;
x = real_position(1);
y = real_position(2);
t = real_position(3);
p(5) = plot(real_position(1), real_position(2), 'mo', ...
    'LineWidth',1.5, ...
    'MarkerEdgeColor','k', ...
    'MarkerFaceColor',[0 1 0], ...
    'MarkerSize',10);

% Show the sensor measurement as an arrow
for lIdx=1:size(real_landmarks,2)
    real_landmark = real_landmarks(:, lIdx);
    if(read_distance(lIdx) < max_read_distance)
        line([real_position(1), real_position(1)+cos(read_angle(lIdx))*read_distance(lIdx)], ...
            [real_position(2), real_position(2)+sin(read_angle(lIdx))*read_distance(lIdx)]);
    end
end

% Show the sensor's field of range
sense_dist(:,1) = real_position(1)+temp_c(:,1);
sense_dist(:,2) = real_position(2)+temp_c(:,2);

p(6) = plot(sense_dist(:,1), sense_dist(:,2), '--');


xlabel('X [m]')
ylabel('Y [m]')

axis([-30, 30, -30, 30]);
