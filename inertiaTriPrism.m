% Calculates the moments of inertia for the wing which in this case is a 45 degree swept triangle. 
% Ref: RefImages/_______
% http://www.eng.auburn.edu/~marghitu/MECH2110/C_4.pdf
function inertias = inertiaTriPrism(b,t,m)
	Ixx = m * (2*t^2/3 + b^2/12);	

	inertias = [Ixx,0,0]';
end
