function cost = stageCost(stageInertMass)
% STAGECOST  Find the cost of a stage based on inert mass.
%
%   [cost] = STAGECOST(stageInertMass) Find the cost of a stage in millions
%   of 2025 dollars based on the stageInertMass
%
%   See also FINDMINCOST, INERTMASS.
    cost = 13.52.*stageInertMass.^0.55;
end