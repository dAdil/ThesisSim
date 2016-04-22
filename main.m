% Thesis simulator for Damian Adil's hovering tail-sitter.

% Reset matlab
clear all;
close all;
clc;

addpath('CommonFunctions');

% Initial conditions
phi0   	= 10.0*pi/180.0;
theta0 	= 0.0*pi/180.0;
psi0   	= -10.0*pi/180.0;

dt 	= 0.01;
t 	= 0:dt:10;

% Gains
P_a = 10; P_e = P_a; P_r = P_a;
I_a = 1; I_e = I_a; I_r = I_a; sum_a = 0; sum_e = 0; sum_r = 0;
D_a = 5; D_e = D_a; D_r = D_a; rx_prev = 0; ry_prev = 0; rz_prev = 0;
p = 0.0; q = 0.0; r = 0.0;

% Aircraft data
Ixx 	= 1.0;
Iyy 	= 0.9;
Izz 	= 1.1;

% 
quat_actual = e2q([phi0,theta0,psi0]);


