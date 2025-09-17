function [minMos] = findMinMass(Mos)
    minMos=zeros(1, length(Mos));
    for k = 1:length(Mos)
        [m,I]=min((Mos(k)));
        minMos(k)=[m,I]
    end
end