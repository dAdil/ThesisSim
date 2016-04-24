% Calculates the moments of inertia for the wing which in this case is a 45 degree swept triangle.
% http://www.eng.auburn.edu/~marghitu/MECH2110/C_4.pdf
function inertias = inertiaTriPrism(b,t,m)
	Ixx = m * (t^2/12 + b^2/24);	
	Iyy = m * (t^2/12 + b^2/72);
	Izz = m * (b^2/18);

	inertias = [Ixx,Iyy,Izz]';
end
