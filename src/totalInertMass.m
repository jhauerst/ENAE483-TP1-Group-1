%% Array of givens
%array = [1:stage height, 2:radius of stage, 3:height of fuel tank, 
% 4:height of oxidizer tank, 5:Propellant mass, 6:fuel fraction, 
% 7:oxidizer fraction, 8:fuel density, 9:oxidizer density, 10:initial mass
% 11: Thrust to Weight ratio, 12:number of engines]
%% Seperate solid fuel from other propellants in calculations

%Names = [1:stage 1 fuel name, 2:stage 1 oxidizer name, 3:stage 1 propellant name
%         4:stage 2 fuel name, 5:stage 2 oxidizer name, 6:stage 2 propellant name]

function [InertMass, i, propellant_names]=totalInertMass(stage1,stage2,propellantname,M0,h,i)
  big_names_array = ["LOX", "LCH4", "LOX/LCH4"; "LOX", "LH2", "LOX/LH2"; "LOX", "RP1", "LOX/RP1"; "Solid", "", "Solid"; "Storables", "", "Storables"];
  startingIndex = 1;
  if i == 2
      startingIndex = 4;
  end
  names = ["","","","","",""];
  names(startingIndex : startingIndex+2) = big_names_array(big_names_array(:,3) == propellantname,:);
    %% Stage one
  if i == 1
    if strcmp(names(3),"Solid")
        propellant_names = "Solid";
        %Fairing for solid propellants on first stage is Aft & Interstage fairing
        [~, ~ ,~ , Interstage, Aft1] = findFairingMass(stage1(2),stage2(2),h);
        %Propellant mass = solid fuel
        solidM = stage1(5);
        %DENSITY OF SOLID PROPELLANT SHOULD BE STORED IN FUEL DENSITY
        solidV = findVolume(solidM,stage1(8));
        propellantTank = findTankMass(solidM, names(3),solidV);
        %find Surface area of tanks
        solidA = 2*pi*stage1(2)*stage1(1) +4*pi*stage1(2)^2;
        %find insulation mass
        insul_solid = findInsulationMass(solidA,names(3));
        %find Engine, Casing & Gimbal masses
        [engineMass1, structureMass1, gimbalsMass1] = stageEngineMass(stage1(10), stage1(5), stage1(11), names(3), stage1(12), 1);
        [~,avionicsMass1] = findWiringa_AvionicsMass(M0,stage2(1));
        [wiringMass1,~] = findWiringa_AvionicsMass(M0,stage1(1));
%         totalMass1 = Interstage+Aft1+propellantTank+insul_solid+engineMass1+structureMass1+gimbalsMass1+wiringMass1+avionicsMass1;
        totalMass1 = [Interstage Aft1 propellantTank insul_solid engineMass1 structureMass1 gimbalsMass1 wiringMass1 avionicsMass1];
    else 
        propellant_names = "else";
        [~, Intertank1 ,~ , Interstage, Aft1] = findFairingMass(stage1(2),stage2(2),h);
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
        Asurf_fuel1 = 2*pi*stage1(2)*stage1(3) +4*pi*stage1(2)^2;%surface area of fuel tank
        Asurf_oxidizer1 = 2*pi*stage1(2)*stage1(4) +4*pi*stage1(2)^2;%surface area of oxidizer tank
        insul_fuel1 = findInsulationMass(Asurf_fuel1,names(1)); %insulaiton mass for fuel tank
        insul_oxid1 = findInsulationMass(Asurf_oxidizer1,names(2)); %insulation mass for oxidizer tank
        % find Engine, Casing, & gimbal masses
        [engineMass1, structureMass1, gimbalsMass1] = stageEngineMass(stage1(10), stage1(5), stage1(11), names(3), stage1(12), 1);
        %find Wiring mass
        [~,avionicsMass1] = findWiringa_AvionicsMass(M0,stage2(1));
        [wiringMass1,~] = findWiringa_AvionicsMass(M0,stage1(1));
        totalMass1 = [Intertank1 Interstage Aft1 fuel_tank1 oxidizer_tank1 insul_oxid1 insul_fuel1 engineMass1 structureMass1 gimbalsMass1 wiringMass1 avionicsMass1 ];
    end 
    InertMass = totalMass1;
  end
    %% Stage two
if i == 2
    if strcmp(names(6),"Solid")
        propellant_names = "Solid";
        %Fairing for solid propellants on second stage is payload fairing
        [Payload2, ~ ,~ , ~, ~] = findFairingMass(0,stage2(2),h)
        %Propellant mass = solid fuel
        solidM2 = stage2(5);
        %DENSITY OF SOLID PROPELLANT SHOULD BE STORED IN FUEL DENSITY
        solidV2 = findVolume(solidM2,stage2(8));
        propellantTank2 = findTankMass(solidM2, names(6),solidV2)
        %find Surface area of tanks
        solidA2 = 2*pi*stage2(2)*stage2(1) +4*pi*stage2(2)^2;
        %find insulation mass
        insul_solid2 = findInsulationMass(solidA2,names(6))
        %find Engine, Casing & Gimbal masses
        [engineMass2, structureMass2, gimbalsMass2] = stageEngineMass(stage2(10), stage2(5), stage2(11), names(6), stage2(12), 2)
     
        [wiringMass2,~] = findWiringa_AvionicsMass(stage2(10),(stage2(1)+13+h))
        %height = 2nd stage height + payload fairing height
        totalMass2 = [Payload2 propellantTank2 insul_solid2 engineMass2 structureMass2 gimbalsMass2 wiringMass2];
    else 
        propellant_names = "else";
        %Fairing mass
        [payload2, ~, Intertank2, ~, ~] = findFairingMass(0,stage2(2),h);
        %Fuel mass & Oxidizer masses
        %Pass propellant mass and ratio
        [Moxidizer2, Mfuel2] = findFuelMass(stage2(5), [stage2(6), stage2(7)]);
        %Find volume of fuel & oxidizer 
        V_fuel2 = findVolume(Mfuel2,stage2(8));%Pass fuel density
        V_oxid2 = findVolume(Moxidizer2,stage2(9));%Pass oxidizer density
        %Find tanks masses
        fuel_tank2 = findTankMass(Mfuel2,names(4),V_fuel2);
        oxidizer_tank2 = findTankMass(Moxidizer2,names(5),V_oxid2);
        %find Surface area of tanks
        Asurf_fuel2 = 2*pi*stage2(2)*stage2(3) +4*pi*stage2(2)^2;%surface area of fuel tank
        Asurf_oxidizer2 = 2*pi*stage2(2)*stage2(4) +4*pi*stage2(2)^2;%surface area of oxidizer tank
        insul_fuel2 = findInsulationMass(Asurf_fuel2,names(4)); %insulaiton mass for fuel tank
        insul_oxid2 = findInsulationMass(Asurf_oxidizer2,names(5)); %insulation mass for oxidizer tank
        % find Engine, Casing, & gimbal masses
        [engineMass2, structureMass2, gimbalsMass2] = stageEngineMass(stage2(10), stage2(5), stage2(11), names(6), stage2(12), 2);
        %find Wiring mass and avionics
        [wiringMass2,~] = findWiringa_AvionicsMass(stage2(10),(stage2(1)+13+h));
        totalMass2 = [payload2 Intertank2 fuel_tank2 oxidizer_tank2 insul_oxid2 insul_fuel2 engineMass2 structureMass2 gimbalsMass2 wiringMass2];
      
    end
    InertMass = totalMass2;
end
  
end
