% Function calculates the controls to be sent to the simulator given the state vector and PID gains. 
function [U,Derr] = calculateControls(X, gains, Derr)
	% Desired orientation
	qd = e2q([0,pi/2,0]);

	% Actual quaternion
	q = X(7:10);

	% Take the conjugate of qa and calculate the error.
	qa(1) = q(1);
	qa(2) = -q(2);
	qa(3) = -q(3);
	qa(4) = -q(4);
	
	qe = [quatMultiply(qa,qd)]';

	% Unit direction of error and magnitude
        thete = 2 * acos(qe(1));
	if thete < 1e-6
		rx = 0;
		ry = 0;
		rz = 0;
	else
        	rx  = qe(2) / (sin(thete/2));
        	ry  = qe(3) / (sin(thete/2));
        	rz  = qe(4) / (sin(thete/2));
	end

	%  Calculate component wise errors and ensure they are within limits. 
        err_phi       = thete * rx;
        err_theta     = thete * ry;
        err_psi       = thete * rz;

        while (err_phi > pi)
            err_phi = err_phi - pi;
        end
        while (err_phi < -pi) 
            err_phi = err_phi + pi;
        end

        while (err_theta > pi) 
            err_theta = err_theta - pi;
        end
        while (err_theta < -pi) 
            err_theta = err_theta + pi;
        end

        while (err_psi > pi) 
            err_psi = err_psi - pi;
        end
        while (err_psi < -pi) 
            err_psi = err_psi + pi;
        end

	% Calculate error in altitude. 
	alt_des = 1;
	err_alt = alt_des - (-1*X(13));

	% Derivative errors
	err_phi_dot = (err_phi - Derr(1)) / 0.01;
	err_theta_dot = (err_theta - Derr(2)) / 0.01;
	err_psi_dot = (err_psi - Derr(3)) / 0.01;
	err_alt_dot = (err_alt - Derr(4)) / 0.01;
	
	Derr(1) = err_phi;
	Derr(2) = err_theta;
	Derr(3) = err_psi;
	Derr(4) = err_alt;

	% Apply gains
	Mx = 0.1524 * (err_phi * gains(1,1) + err_phi_dot * gains(3,1));
	My = 0.3700 * (err_theta * gains(1,2) + err_theta_dot * gains(3,2));
	Mz = 0.1524 * (err_psi * gains(1,3) + err_psi_dot * gains(3,3));

	Fx = err_alt * gains(1,4) + err_alt_dot * gains(3,4) + 0.840*9.81;

        % Calculate outputs.
        servoL = atan2(My - Mx, Fx - Mz);
        servoR = atan2(My + Mx, Fx + Mz);

        servoL = lim(servoL, 60*pi/180);
        servoR = lim(servoR, 60*pi/180);

        throttleL = (Fx - Mz) / (2 * cos(servoL));
        throttleR = (Fx + Mz) / (2 * cos(servoR));

	% Turn outputs into PWM values. 
        U(1,1)   =  ( servoL * 180 / pi * 10 ) + 1500;
        U(2,1)   =  ( servoR * 180 / pi * 10 ) + 1500;
        U(3,1)   = 1000 * throttleL / 5.886 + 1000;
        U(4,1)   = 1000 * throttleR / 5.886 + 1000;

	% Limit PWM values. 
	if U(1,1) > 2100
		U(1,1) = 2100;
	elseif U(1,1) < 900
		U(1,1) = 900;
	end

	if U(2,1) > 2100
		U(2,1) = 2100;
	elseif U(2,1) < 900
		U(2,1) = 900;
	end

	if U(3,1) > 2000
		U(3,1) = 2000;
	elseif U(3,1) < 1000
		U(3,1) = 1000;
	end

	if U(4,1) > 2000
		U(4,1) = 2000;
	elseif U(4,1) < 1000
		U(4,1) = 1000;
	end
end
