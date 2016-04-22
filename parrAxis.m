% Uses the parallel axis theorem to calculate inertias at the C.G. 
% http://ocw.mit.edu/courses/aeronautics-and-astronautics/16-07-dynamics-fall-2009/lecture-notes/MIT16_07F09_Lec26.pdf
function [Ixx,Iyy,Izz,Ixy,Ixz,Iyz] = parrAxis(inertiaVector,centroid,m)
	Ixx = inertiaVector(1) + m * (centroid(2)^2 + centroid(3)^2);
	Iyy = inertiaVector(2) + m * (centroid(1)^2 + centroid(3)^2);
	Izz = inertiaVector(3) + m * (centroid(1)^2 + centroid(2)^2);

	Ixy = inertiaVector(4) + m * centroid(1) * centroid(2);
	Ixz = inertiaVector(5) + m * centroid(1) * centroid(3);
	Iyz = inertiaVector(6) + m * centroid(2) * centroid(3);
end
