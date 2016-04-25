% Thesis simulator for Damian Adil's hovering tail-sitter.

% Reset matlab
clear all;
close all;
clc;

addpath('CommonFunctions');
fileID = fopen('log.txt','w');

% Aircraft data and constants
global g m Ixx Iyy Izz Ixz;
g = 9.81;

m = 0.840;

aircraftInertias;
Ixx = inertia(1);
Iyy = inertia(2);
Izz = inertia(3);
Ixz = inertia(5);

% Initial conditions
phi0   	= 10.0*pi/180.0;
theta0 	= 0.0*pi/180.0;
psi0   	= -10.0*pi/180.0;

dt 	= 0.01;
t 	= 0:dt:10;

% Initial state vector 
% u,v,w,p,q,r,q0,q1,q2,q3,x,y,z

X = [0,0,0,0,0,0,[e2q([phi0;theta0;psi0])]',0,0,0]';
U = [1500,1500,1500,1500]';

% Step forward integration
for i = 1:length(t)
	X = integrate(X,U,dt);
	fprintf(fileID,"%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%d,%d,%d,%d,%4.4f\n",X(1),X(2),X(3),X(4),X(5),X(6),X(7),X(8),X(9),X(10),X(11),X(12),X(13),U(1),U(2),U(3),U(4),t(i));
end


