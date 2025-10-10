function [radius_ofthrust] = RocketDiameter(nEngines,diameter)
% Emma and Joseph mainly worked on this code
radius = diameter/2;
% curve fit of first 20 known solutions for packing a circle in a circle
a = 1.486;
b = 0.4277;
radius_multiplier = a*nEngines^b;
radius_ofthrust = radius_multiplier*radius;
end