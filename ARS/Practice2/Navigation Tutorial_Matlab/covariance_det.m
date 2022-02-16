function r = covariance_det(omega,Ai,Bi)

%omega = 0.5
r = 1/det(omega*Ai+(1-omega)*Bi);
