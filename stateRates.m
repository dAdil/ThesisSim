% Function to calculate the rate of changeof the state variables
% http://web.aeromech.usyd.edu.au//flightm/aero3500/AERO3560_Week_2_Slides.pdf
function Xdot = stateRates(X,controls)
	% Variable declarations
	global g m Ixx Iyy Izz Ixz;
	Xdot = zeros(13,1);

	% Calculate body forces [Fx,Fy,Fz,Mx (L),My (M),Mz (N)]'
	BodyForces = bodyForces(controls);
	
	% Calculate euler angles (required for uvw dot calculations)
	eulers = q2e(X(7:10)); 

	% uvw dot
	Xdot(1) = X(6)*X(2) - X(5)*X(3) - g*sin(eulers(2)) + BodyForces(1)/m;
	Xdot(2) = -X(6)*X(1) + X(4)*X(3) + g*sin(eulers(1))*cos(eulers(2)) + BodyForces(2)/m;
	Xdot(3) = X(5)*X(1) - X(4)*X(2) + g*cos(eulers(1))*cos(eulers(2)) + BodyForces(3)/m;

	% Inertial constants (required for pqr dot calculations)
	C0 = Ixx * Izz * Ixz^2;
	C1 = Izz / C0;
	C2 = Ixz / C0;
	C3 = C2 * (Ixx - Iyy + Izz);
	C4 = C1 * (Iyy - Izz) - C2 * Ixz;
	C5 = 1 / Iyy;
	C6 = C5 * Ixz;
	C7 = C5 * (Izz - Ixx);
	C8 = Ixx / C0;
	C9 = C8 * (Ixx - Iyy) + C2 * Ixz;

	% pqr dot
	Xdot(4) = C3 * X(4) * X(5) + C4 * X(5) * X(6) + C1 * BodyForces(4) + C2 * BodyForces(6);
	Xdot(5) = C7 * X(4) * X(6) - C6 * (X(4)^2 - X(6)^2) + C5 * BodyForces(5);
	Xdot(6) = C9 * X(4) * X(5) - C3 * X(5) * X(6) + C2 * BodyForces(4) + C8 * BodyForces(6);

	% Quaternion dot
	Xdot(7) = -0.5 * (X(8) * X(4) + X(9) * X(5) + X(10) * X(6));
	Xdot(8) =  0.5 * (X(7) * X(4) - X(10) * X(5) + X(9) * X(6));
	Xdot(9) =  0.5 * (X(10) * X(4) + X(7) * X(5) - X(8) * X(6));
	Xdot(10) = -0.5 * (X(9) * X(4) - X(8) * X(5) - X(7) * X(6));
	
	% Navigation (required for xyz dot calculations)
	C_EB = [cos(eulers(3))*cos(eulers(2)), cos(eulers(3))*sin(eulers(2))*sin(eulers(1))-sin(eulers(3))*cos(eulers(1)), cos(eulers(3))*sin(eulers(2))*cos(eulers(1))+sin(eulers(3))*sin(eulers(1));
		sin(eulers(3))*cos(eulers(2)), sin(eulers(3))*sin(eulers(2))*sin(eulers(1))-cos(eulers(3))*cos(eulers(1)), sin(eulers(3))*sin(eulers(2))*cos(eulers(1))-cos(eulers(3))*sin(eulers(1));
		-sin(eulers(2))              , cos(eulers(2))*sin(eulers(1))                                             , cos(eulers(2))*cos(eulers(1))];

	% xyz dot
	Xdot(11:13) = C_EB * [X(1);X(2);X(3)];
end
