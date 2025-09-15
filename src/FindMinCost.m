function [minCost] = FindMinCost(costs)
    minCost=zeros(1,length(costs));
    for k = 1:length(costs)
        [c,I]=min((costs(k)));
        minCost(k)=[c,I]
    end
end