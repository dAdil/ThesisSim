function plotAngles()
	M = csvread('log.txt');
	M(end,:) = [];

	q = M(:,7:10);
	t = M(:,18);

	% Calculations in the simulator are done on a LVLH basis. We would prefer to display the angles zerod around 90 degrees of pitch. 
	% Take -90 degrees as we are subtracting r from q. 
	r = e2q([0;-pi/2;0]);

	for i = 1:size(M,1)
		qnew(i,:) = [quatMultiply(q(i,:),r)]';
		enew(i,:) = [q2e(qnew(i,:))]' .* 180/pi;
	end

	figure();
	subplot(1,3,1);
	plot(t,qnew(:,1),t,qnew(:,2),t,qnew(:,3),t,qnew(:,4));
	legend('q0','q1','q2','q3');
	axis([min(t),max(t),-1.01,1.01]);

	subplot(1,3,2);
	plot(t,enew(:,1),t,enew(:,2),t,enew(:,3));
	legend('\phi','\theta','\psi');
	axis([min(t),max(t),-20,20]);

	subplot(1,3,3);
	plot(t,-M(:,13))
end
