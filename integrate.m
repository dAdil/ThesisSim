% Runge-Kutta Integration
% http://web.aeromech.usyd.edu.au//flightm/aero3500/Week_11_transparencies2.pdf
function Y = integrate(X,U,dt)
	An = stateRates(X,U) * dt;
	Bn = stateRates(X + An / 2, U) * dt;
	Cn = stateRates(X + Bn / 2, U) * dt;
	Dn = stateRates(X + Cn, U) * dt;
	
	Y  = X + 1 / 6 * (An + 2*Bn + 2*Cn + Dn);
	Y(7:10) = Y(7:10) / sqrt(Y(7)^2+Y(8)^2+Y(9)^2+Y(10)^2);
end
