% Script to calculate the inertias of the aircraft

% Reset matlab
clear all;
close all;
clc;

% Initialise
inertia = zeros(6,1);

% Battery
inertia	= inertia + parrAxis([inertiaRectPrism(0.050,0.120,0.050,0.210);0;0;0],[0.190;0;-0.025],0.210);

% Nose mount (approximated as rectangular prism)
inertia	= inertia + parrAxis([inertiaRectPrism(0.04,0.04,0.01,0.02);0;0;0],[0.260;0;-0.005],0.02);

% Motor + servo + mount LEFT
inertia = inertia + parrAxis([inertiaCylinder(0.025,0.09,0.105);0;0;0],[-0.32,-0.152,-0.002],0.105);

% Motor + servo + mount RIGHT
inertia = inertia + parrAxis([inertiaCylinder(0.025,0.09,0.105);0;0;0],[-0.32,0.152,-0.002],0.105);

% ESC LEFT
inertia = inertia + parrAxis([inertiaRectPrism(0.04,0.04,0.01,0.025);0;0;0],[-0.29,-0.075,-0.005],0.025);

% ESC RIGHT
inertia = inertia + parrAxis([inertiaRectPrism(0.04,0.04,0.01,0.025);0;0;0],[-0.29,0.075,-0.005],0.025);

% Wiring
inertia = inertia + parrAxis([inertiaCylinder(0.005,0.290,0.04);0;0;0],[-0.145,0,-0.025],0.04);

% Pixhawk
inertia = inertia + parrAxis([inertiaRectPrism(0.01,0.05,0.01,0.04);0;0;0],[0,0,-0.02],0.04);

% Propeller LEFT
inertia = inertia + parrAxis([inertiaCylinder(0.127,0.01,0.011);0;0;0],[-0.37,-0.152,0],0.011);

% Propeller RIGHT
inertia = inertia + parrAxis([inertiaCylinder(0.127,0.01,0.011);0;0;0],[-0.37,0.152,0],0.011);

% Airframe
% ========
% Upper wing
inertia = inertia + parrAxis([inertiaTriPrism(1,0.006,0.118);0;0;0],[-0.07;0;0],0.118);
% Lower wing
inertia = inertia + parrAxis([inertiaRectPrism(0.05,1,0.006,0.024);0;0;0],[-0.265,0,0],0.024);
% Left Stand
StandInertia1 = inertiaTriPrism(0.36,0.006,0.028);
StandInertia2(1,1) = StandInertia1(1,1);
StandInertia2(2,1) = StandInertia1(3,1);
StandInertia2(3,1) = StandInertia1(2,1);
inertia = inertia + parrAxis([StandInertia2;0;0;0],[-0.265;-0.305;0],0.028);
% Right Stand
inertia = inertia + parrAxis([StandInertia2;0;0;0],[-0.265;0.305;0],0.028);
% Left Stringer
inertia = inertia + parrAxis([inertiaRectPrism(0.4,0.006,0.05,0.009);0;0;0],[-0.09,-0.15,0],0.009);
% Right Stringer
inertia = inertia + parrAxis([inertiaRectPrism(0.4,0.006,0.05,0.009);0;0;0],[-0.09,0.15,0],0.009);
% Center Stringer
inertia = inertia + parrAxis([inertiaRectPrism(0.55,0.006,0.13,0.034);0;0;0],[-0.015,0,0],0.034);
