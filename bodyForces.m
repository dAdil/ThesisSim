% Function calculates the body forces of the VTOL aircraft 
% NOTE: Aerodynamic forces are not considered as the aircraft is moving very slowly in hover. 
function Forces = bodyForces(controls)
	theta_L = controls(1);
	theta_R = controls(2);
	motor_L = controls(3);
	motor_R = controls(4);
	
	% Convert pwm values to Newtons and Radians
	theta_L = (theta_L - 1500) / 600  * pi / 3;
	theta_R = (theta_R - 1500) / 600  * pi / 3;
	motor_L = (motor_L - 1000) / 1000 * 5.886;
	motor_R = (motor_R - 1000) / 1000 * 5.886;

	% Calculate forces and moments
	Fx = motor_L * cos(theta_L) + motor_R * cos(theta_R);
	Fy = 0;
	Fz = motor_L * sin(theta_L) + motor_R * sin(theta_R);

	Mx = (6*25.4/1000)*(-motor_L * sin(theta_L) + motor_R * sin(theta_R));
	My = (0.370)*(motor_L * sin(theta_L) + motor_R * sin(theta_R));
	Mz = (6*24.4/1000)*(-motor_L * cos(theta_L) + motor_R * cos(theta_R));

	% Output vector
	Forces = [Fx, Fy, Fz, Mx, My, Mz]';
end
