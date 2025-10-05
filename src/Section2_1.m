chi1 = 0.54 ; % min mass soln
chi2 = 0.53 ; % min cost soln
delta = 0.08;
M0_mass = 2.375e+6; % results from submission 1
M0_cost = 2.412e+6;
    stage = 1;
[nEngines, diameter_ofthrust] = EngineDimension(stage,m0,prop);
radius = diameter_ofthrust/2;
% height function goes here
min_radius = 1000;
while radius < height
    
    radius = radius + 0.1;
    % height function based on new radius
    if radius < min_radius
        min_radius = radius;
    end
end

