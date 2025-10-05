%% Array of givens
%array = [1:stage height, 2:radius of stage, 3:radius of fuel tank, 
% 4:radius of oxidizer tank, 5:Propellant mass, 6:fuel fraction, 
% 7:oxidizer fraction, ]
%Names = [1:stage 1 fuel name, 2:stage 1 oxidizer name]
stage1 = [h1, r, rt1, rt2]; 
stage2 = [];
names = [];

function [mass_total_inert]=totalInertMass(stage1,stage2,names)
    %% Stage one
    %Fairing mass
    [~, Intertank1, Aft1] = findFairingMass(stage1(2), stage1(3), stage1(4),stage1(1));
    %Fuel mass & Oxidizer masses
    [Moxidizer, Mfuel] = findFuelMass(stage1(5), [stage1(6), stage1(7)]);
    %Find volume of fuel & oxidizer 
    fuel_tank = findTankMass(Mfuel,names(1),V_fuel);
    oxidizer_tank = findTankMass(Moxidizer,names(2),V_oxz);
    %AT=2*pi*rf1*h+2*pi*rf1^2;
    
    mass_total_inert = TotalFairingMass;
    %% Stage two
end