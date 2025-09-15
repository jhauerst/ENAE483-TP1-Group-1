function [minMos] = FindMinMass(Mos)
    minMos=zeros(size(Mos));
    for k = 1:length(Mos)
        [m,I]=min((Mos(k)));
        minMos(k)=[m,I]
    end
end