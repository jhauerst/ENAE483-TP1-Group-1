%% Array of givens
%array = [stage height, radius of stage, radius of fuel tank, 
% radius of oxidizer tank, ]
array1 = [h1, r, rt1, rt2]; 
array2 = [];

function [mass_total_inert]=totalInertMass(array1,array2)
    %% Stage one
    %Fairing mass
    [~, Intertank1, Aft1] = findFairingMass(array1(2), array1(3), array1(4),array1(1));
    %AT=2*pi*rf1*h+2*pi*rf1^2;
    
    mass_total_inert = TotalFairingMass;
    %% Stage two
end