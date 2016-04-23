% Calculates the moments of inertia of a cylinder.
% https://en.wikipedia.org/wiki/List_of_moments_of_inertia
% NOTE: Axis are x-axis aligned with center of circle. 
function inertias = inertiaCylinder(r,h,m)
	Ixx = m / 12 * (3 * r^2 + h^2);
	Iyy = Ixx;
	Izz = m * r^2 / 2;

	inertias = [Ixx,Iyy,Izz]';
end
