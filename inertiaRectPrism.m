% Calculates the moments of inertia of a rectangular prism. 
% http://www.eng.auburn.edu/~marghitu/MECH2110/C_4.pdf
function inertias = inertiaRectPrism(a,b,c,m)
	Ixx = 1/12 * m * (b^2 + c^2);
	Iyy = 1/12 * m * (a^2 + c^2);
	Izz = 1/12 * m * (a^2 + b^2);

	inertias = [Ixx,Iyy,Izz]';
end
