function [radius_ofthrust] = RocketDiameter (nEngines,diameter)
radius = diameter/2;
if nEngines == 1
    radius_ofthrust = radius;
elseif nEngines == 2
    radius_ofthrust = radius*2;
elseif nEngines == 3
    radius_ofthrust = (1+(2/(3)^0.5))*radius;
elseif nEngines == 4
    radius_ofthrust = radius*(1+sqrt(2));
elseif nEngines == 5
    radius_ofthrust = radius*(1+sqrt(2*(1+(1/sqrt(5)))));
elseif nEngines == 6
    radius_ofthrust = radius*3;
elseif nEngines == 7
    radius_ofthrust = radius*3;
elseif nEngines == 8
    radius_ofthrust = radius*(1+sin(pi/7));
elseif nEngines == 9
    radius_ofthrust = radius*(1+sqrt(2*(2+sqrt(2))));
elseif nEngines == 10
    radius_ofthrust = radius*3.813;
elseif nEngines == 11
    radius_ofthrust = radius*(1+(1/sin(pi/9)));
elseif nEngines == 12
    radius_ofthrust = radius*4.029;
elseif nEngines == 13
    radius_ofthrust = radius*(2+sqrt(5));
elseif nEngines == 14
    radius_ofthrust = radius*4.328;
elseif nEngines == 15
    radius_ofthrust = radius*4.521;
elseif nEngines == 16
    radius_ofthrust = radius*4.615;
elseif nEngines == 17
    radius_ofthrust = radius*4.792;
elseif nEngines == 18
    radius_ofthrust = radius*(1+sqrt(2)+sqrt(6));
elseif nEngines == 19
    radius_ofthrust = radius*(1+sqrt(2)+sqrt(6));
elseif nEngines == 20
    radius_ofthrust = radius*5.122;
else
    disp("Error: Too many engines")
end