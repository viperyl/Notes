function omega = omega_value(Ai,Bi)

omega = fminbnd('covariance_det',0,1,[],Ai,Bi);