function [z, H] = Measurement(pos, landmark_pos, observation_variance)

% Compute the distance from the given pos to the landmark
vector_to_landmark = [landmark_pos(1) - pos(1); landmark_pos(2) - pos(2)];
landmark_distance0 = ;

% Compute the angle from the given pos to the landmark
landmark_angle0    = ;

% Compute the Jacobian of this measurement function
q = landmark_distance0^2.0;
H = [  ];

% Add Gaussian noise to measurement
landmark_distance = landmark_distance0 + normrnd(0, observation_variance(1)*.25);
landmark_angle = landmark_angle0 + normrnd(0, observation_variance(2)*.25);

z = [landmark_distance;
    landmark_angle];

end
