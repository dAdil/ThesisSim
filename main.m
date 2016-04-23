% Thesis simulator for Damian Adil's hovering tail-sitter.

% Reset matlab
clear all;
close all;
clc;

addpath('CommonFunctions');

% Aircraft data and constants
global g m Ixx Iyy Izz Ixz;
g = 9.81;

m = 0.840;

Ixx = 0;
Iyy = 0;
Izz = 0;
Ixz = 0;

% Initial conditions
phi0   	= 10.0*pi/180.0;
theta0 	= 0.0*pi/180.0;
psi0   	= -10.0*pi/180.0;

dt 	= 0.01;
t 	= 0:dt:10;

% Initial state vector 
% u,v,w,p,q,r,q0,q1,q2,q3,x,y,z

X = [0,0,0,0,0,0,[e2q([phi0;theta0;psi0])]',0,0,0]';


