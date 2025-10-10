function [cost, index] = findMinCost(costs)
% Joseph worked on this code
% FINDMINCOST  Find the minimum cost given a list of total vehicle costs.
% 
%   [cost, index] = FINDMINCOST(costs) Finds the minimum cost in costs.
%
%   See also FINDMINMASS, STAGECOST.


    [cost,index]=min(costs);
end