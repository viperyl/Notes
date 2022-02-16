function newpos = Propagation(pos, vel_cmd, variance)
global DT

% pos(1) : x
% pos(2) : y
% pos(3) : psi

% Integration step size : DT   

% Velocity command
speed      = vel_cmd(1);
psi_dot    = vel_cmd(2);

% Propagation equation
vel(1,1) =  ;
vel(2,1) =  ;
vel(3,1) =  ;

% Add noise
vel = vel + [normrnd(0,variance(1),2,1);normrnd(0,variance(2))];

newpos = pos + vel*DT;
end
