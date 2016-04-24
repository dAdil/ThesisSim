% Matlab/Octave function to turn quaternions into euler angles.
% http://web.aeromech.usyd.edu.au//flightm/aero3500/AERO3560_Week_2_Slides.pdf
function e  = q2e(q)
    q0	= q(1);
    q1	= q(2);
    q2	= q(3);
    q3  = q(4);	

    theta = atan2(q0*q2-q1*q3,((q0^2+q1^2-0.5)^2+(q1*q2+q0*q3)^2)^0.5);
    phi   = atan2(q2*q3+q0*q1,q0^2+q3^2-0.5);
    psi   = atan2(q1*q2+q0*q3,q0^2+q1^2-0.5);

    e = [phi,theta,psi]';
end
