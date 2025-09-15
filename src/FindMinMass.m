function [minMos] = FindMinMass(Mos)
    minMos=zeros(1,size(Mos));
    for k = 1:size(Mos)
        [m,I]=min((Mos(k)));
        minMos(k)=[m,I]
    end
end