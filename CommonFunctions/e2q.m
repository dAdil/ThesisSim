% Matlab/Octave function to turn euler angles into quaternions.
% http://web.aeromech.usyd.edu.au//flightm/aero3500/AERO3560_Week_2_Slides.pdf
function q  = e2q(e)

    phi     = e(1);
    theta   = e(2);
    psi     = e(3);
	
    q    = zeros(4,1);

    q(1) =  (cos(psi/2) * cos(theta/2) * cos(phi/2)) + (sin(psi/2) * sin(theta/2) * sin(phi/2));
    q(2) =  (cos(psi/2) * cos(theta/2) * sin(phi/2)) - (sin(psi/2) * sin(theta/2) * cos(phi/2));
    q(3) =  (cos(psi/2) * sin(theta/2) * cos(phi/2)) + (sin(psi/2) * cos(theta/2) * sin(phi/2));
    q(4) = -(cos(psi/2) * sin(theta/2) * sin(phi/2)) + (sin(psi/2) * cos(theta/2) * cos(phi/2));
end
