function [mass, index] = findMinMass(Mos)
% FINDMINMASS  Find the minimum mass given a list of total vehicle masses.
%
%   [mass, index] = FINDMINMASS(Mos) Finds the minimum mass in Mos.
%
%   See also FINDMINCOST.


    % call min function to find the min total mass, return the mass value
    % and index
    [mass,index]=min(Mos);
end