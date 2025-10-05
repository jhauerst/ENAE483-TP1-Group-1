%% Array of givens
%array = [1:stage height, 2:radius of stage, 3:radius of fuel tank, 
% 4:radius of oxidizer tank, 5:Propellant mass, 6:fuel fraction, 
% 7:oxidizer fraction, 8:fuel density, 9:oxidizer density ]

%Names = [1:stage 1 fuel name, 2:stage 1 oxidizer name]
stage1 = [h1, r, rt1, rt2]; 
stage2 = [];
names = [];

function [mass_total_inert]=totalInertMass(stage1,stage2,names)
    %% Stage one
    %Fairing mass
    [~, Intertank1, Aft1] = findFairingMass(stage1(2), stage1(3), stage1(4),stage1(1));
    %Fuel mass & Oxidizer masses
    %Pass propellant mass and ratio
    [Moxidizer1, Mfuel1] = findFuelMass(stage1(5), [stage1(6), stage1(7)]);
    %Find volume of fuel & oxidizer 
    V_fuel1 = findVolume(Mfuel1,stage1(8));%Pass fuel density
    V_oxid1 = findVolume(Moxidizer1,stage1(9));%Pass oxidizer density
    %Find tanks masses
    fuel_tank1 = findTankMass(Mfuel1,names(1),V_fuel1);
    oxidizer_tank1 = findTankMass(Moxidizer1,names(2),V_oxid1);
    %find Surface area of tanks
    h_fuel1 =findTankHeight(Mfuel1,stage1(3),stage1(8)); %height of fuel tank
    h_oxid1 =findTankHeight(Moxidizer1,stage1(4),stage1(9)); %height of oxidizer tank
    Asurf_fuel1 = 2*pi*stage1(3)*h_fuel1 +4*pi*stage1(3)^2;%surface area of fuel tank
    Asurf_oxidizer1 = 2*pi*stage1(4)*h_oxid1 +4*pi*stage1(4)^2;%surface area of oxidizer tank
    insul_fuel1 = findInsulationMass(Asurf_fuel1,names(1)); %insulaiton mass for fuel tank
    insul_oxid1 = findInsulationMass(Asurf_oxidizer1,names(2)); %insulation mass for oxidizer tank
    % find 
    
    mass_total_inert = TotalFairingMass;
    %% Stage two
end