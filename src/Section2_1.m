%% Main Section Code for 2.1

clear; clc; close all;
propNames = ["LOX/LCH4" "LOX/LH2" "LOX/RP1" "Solid" "Storables"];
%propNames = ["LOX/LH2"];
Propellantstage1 = "LOX/LCH4"; % user changed

h = 4; % meters, we decided as a team vote
chi1 = 0.54 ; % min mass soln
chi2 = 0.53 ; % min cost soln
delta = 0.08;
%tolarence 0.05 for mass margin

vehicleParamsSize = 7; % if you add a vehicleParam later, change this number
allOptimizedVehicles = zeros(length(propNames)*2,vehicleParamsSize);
massMargins = zeros(length(propNames),1);
totalMasses = zeros(2,length(propNames));
chiValues = zeros(length(propNames),1);
deltaValues = zeros(length(propNames),1);
for k = 1:length(propNames)     % Going through all the propellant names/combinations

    firstIteration = true;
    mass_margin = 0;

    while mass_margin < 0.3 || mass_margin > 0.301    % This is to update the delta, if it is not the first iteration, until a mass margin of 30% is achieved
        
        if ~ firstIteration 
            if mass_margin < 0.3
                %delta = delta + 0.0001;
                % adaptive step
                delta = delta + max(abs(mass_margin-0.3)/100, 1e-5);
            elseif mass_margin > 0.301
                %delta = delta - 0.0001;
                % adaptive step
                delta = delta - max(abs(mass_margin-0.3)/100, 1e-5);
            end
        else
            firstIteration = false;
        end
        
        Propellants = [Propellantstage1, propNames(k)];     % user's specific propellant combination
        [ Mo_min, Min1_min,Min2_min,Mo1_min, Mo2_min,Mpr1_min,Mpr2_min, chi_min] = submission1 (delta, Propellantstage1, propNames(k)); % Grab submission 1 masses
        chiValues(k) = chi_min;

        vehicle_inertMass1 = Min1_min + Min2_min;
        m0 = [Mo_min, Mo2_min];     % stage 1 and 2 array
        totalMasses(:,k) = m0;
        Mpr0 = [Mpr1_min Mpr2_min]; % stage 1 and 2 array
        thrust_weight_ratio = [1.3 0.76];
        vehicle_inertMass2 = 0;
        previous_radius = 0;
        previous_stage = [];

        vehicleParams = [[]; []];
        
        for i=2:-1:1    % start with stage 2 and go to stage 1
            stage = i;
            [nEngines, diameter_ofthrust] = EngineDimension(stage, m0(stage), Propellants(stage));  % find number of engines and diameter of all those engines
            radius = diameter_ofthrust/2;
          
            [height, fuelh, h_oxidizer, ratio, rho] = findTankHeight(Mpr0(i),radius, Propellants(stage));     % function to find height of tank
            min_radius = Inf;   % intializing variable, high number
            min_height = Inf;
            minInertmass = Inf; % intializing variable, high number
            minstageArray = [];
            minEngines = Inf;
        
            while radius < height  % constraint
                radius = radius + 0.1; % keep increasing radius until constraint is met
              
                [height, fuelh, h_oxidizer, ratio, rho] = findTankHeight(Mpr0(i),radius, Propellants(i));  % new height based on new radius
                L = height;
                D = radius*2;
            
                if L/D > 13 || radius < previous_radius || D < 5.3 % if condition not met then skip to the next iteration
                    continue
                end    

                %array = [1:stage height, 2:radius of stage, 3:height of fuel tank, 
                % 4:height of oxidizer tank, 5:Propellant mass, 6:fuel fraction, 
                % 7:oxidizer fraction, 8:fuel density, 9:oxidizer density, 10:initial mass
                % 11: Thrust to Weight ratio, 12:number of engines]
                stageArray = [height, radius, fuelh, h_oxidizer, Mpr0(stage), ratio(2), ratio(1), rho(2), rho(1), m0(stage), thrust_weight_ratio(stage), nEngines];
                stage1_array = [];
                stage2_array = stageArray;
                if stage == 1
                    stage1_array = stageArray;
                    stage2_array = previous_stage;
                end

            [InertMass, stage, propellant_names] = totalInertMass(stage1_array,stage2_array,Propellants(stage),m0(stage),h,stage);
            currentInertMass = sum(InertMass);  
             
                if currentInertMass < minInertmass   % check for new minimum inert mass
                    min_radius = radius;                 % new minimum radius
                    min_height = height;                 % new minimum height
                    minInertmass = currentInertMass;     % new minimum inert mass
                    minstageArray = stageArray;
                    minEngines = nEngines;
                end
            end
            
            previous_radius = min_radius;       % update the previous radius
            vehicle_inertMass2 = minInertmass + vehicle_inertMass2;      % add the inert masses
            previous_stage = minstageArray;
            
            vehicleParams(stage,:) = [minEngines min_radius min_height minInertmass Mpr0(stage) m0(stage) thrust_weight_ratio(stage)];
            
        end
            allOptimizedVehicles(2*k-1:2*k, :) = vehicleParams;
            mass_margin = (vehicle_inertMass1 - vehicle_inertMass2)/(vehicle_inertMass2);  % calculate the mass margin
            massMargins(k) = mass_margin
            deltaValues(k) = delta;

    end % end of while loop 

end

for k=1:(length(allOptimizedVehicles(:,1))/2)
    disp(Propellantstage1 + ", " + propNames(k))
    for l=0:1
        index = 2*k+l-1;
    fprintf("Stage: %d \tEngines: %d \tRadius: %f \tHeight: %f \tInert Mass: %d \t\nPropellant Mass: %d \tInitial Stage Mass: %d \tTWR: %d \tMass Margin: %d\n\n", ...
        l+1, ...
        allOptimizedVehicles(index, 1), ...
        allOptimizedVehicles(index, 2), ...
        allOptimizedVehicles(index, 3), ...
        allOptimizedVehicles(index, 4), ...
        allOptimizedVehicles(index, 5), ...
        allOptimizedVehicles(index, 6), ...
        allOptimizedVehicles(index, 7), ...
        massMargins(k))
    end
end

for k=1:(length(allOptimizedVehicles(:,1))/2)
    index = 2*k-1;
    nEngines = [allOptimizedVehicles(index, 1) allOptimizedVehicles(index+1, 1)];
    radii = [allOptimizedVehicles(index, 2) allOptimizedVehicles(index+1, 2)];
    heights = [allOptimizedVehicles(index, 3) allOptimizedVehicles(index+1, 3)];
    
    Mpr0 = [allOptimizedVehicles(index, 5) allOptimizedVehicles(index+1, 5)];
    [height1, fuelh1, h_oxidizer1, ratio1, rho1] = findTankHeight(Mpr0(1),radii(1), Propellantstage1);  % new height based on new radius
    [height2, fuelh2, h_oxidizer2, ratio2, rho2] = findTankHeight(Mpr0(2),radii(2), propNames(k));  % new height based on new radius]
    fuel_heights = [fuelh1 fuelh2];
    oxidizer_heights = [h_oxidizer1 h_oxidizer2];
    ratios = [ratio1; ratio2];
    rhos = [rho1; rho2];
    thrust_weight_ratio = [1.3 0.76];
    m0 = totalMasses(:,k);

    stageArray1 = [heights(1), radii(1), fuel_heights(1), oxidizer_heights(1), Mpr0(1), ratios(2,1), ratios(1,1), rhos(2,1), rhos(1,1), m0(1), thrust_weight_ratio(1), nEngines(1)];
    stageArray2 = [heights(2), radii(2), fuel_heights(2), oxidizer_heights(2), Mpr0(2), ratios(2,2), ratios(1,2), rhos(2,2), rhos(1,2), m0(2), thrust_weight_ratio(2), nEngines(2)];

    % Need: Stage, Chi, Propellant, 
    % Propellant Tanks S1, Propellant Tanks S2, Tank Insulation S1, Tank Insulation S2, 
    % Engine S1, Engine S2, Thrust Structure S1, Thrust Structure S2, Casing S1, Casing S2, Gimbals S1, Gimbals S2, 
    % Avionics (S2), Wiring S1, Wiring S2, 
    % Payload Fairing, Inter Tank Fairing S1, Inter Tank Fairing S2, Inter Stage Fairing, Aft Fairing

    S2Avionics = 0;
    inertMassSum = 0;
    costSum = 0;

    fprintf("Propellants: %s %s\n\n", Propellantstage1, propNames(k))

for stage=1:2

    [InertMass, ~, propellant_names] = totalInertMass(stage1_array,stage2_array,Propellants(stage),m0(stage),h,stage);

    % Array guide for subsystem masses: 
    % 1 --> if i = 1 , propellant_name = "Solid" : totalMass1 = [Interstage Aft1 propellantTank insul_solid engineMass1 structureMass1 gimbalsMass1 wiringMass1 avionicsMass1];
    % 2 --> if i = 1 , propellant_name = "else" : totalMass1 = [Intertank1 Interstage Aft1 fuel_tank1 oxidizer_tank1 insul_oxid1 insul_fuel1 engineMass1 structureMass1 gimbalsMass1 wiringMass1 avionicsMass1 ];
    % 3 --> if i = 2 , propellant_name = "Solid" : totalMass2 = [Payload2 propellantTank2 insul_solid2 engineMass2 structureMass2 gimbalsMass2 wiringMass2];
    % 4 --> if i = 2 , propellant_name = "else" : totalMass2 = [payload2 Intertank2 fuel_tank2 oxidizer_tank2 insul_oxid2 insul_fuel2 engineMass2 structureMass2 gimbalsMass2 wiringMass2];
    
    displayString = "Stage: %d\tChi: %f\tPropellant: %d\tDelta: %f\n" + ...
        "Propellant Tanks: %d\tTank Insulation: %d\t\n" + ...
        "Engines: %d\tThrust Structure: %d\tCasing: %d\tGimbals: %d\t\n" + ...
        "Avionics: %d\tWiring: %d\n" + ...
        "Payload Fairing: %d\tIntertank Fairing: %d\tInterstage Fairing: %d\tAft Fairing: %d\n\n";
    if (stage == 1 && strcmp(propellant_names, "Solid"))
        S2Avionics = InertMass(9);
        fprintf(displayString, ...
            stage, chiValues(k), Mpr0(stage), deltaValues(k), ...
            InertMass(3), InertMass(4), ...
            0, InertMass(6), InertMass(5), InertMass(7), ...
            0, InertMass(8), ...
            0, 0, InertMass(1), InertMass(2));
    elseif (stage == 1 && strcmp(propellant_names, "else"))
        S2Avionics = InertMass(12);
        fprintf(displayString, ...
            stage, chiValues(k), Mpr0(stage), deltaValues(k), ...
            InertMass(4)+InertMass(5), InertMass(6)+InertMass(7), ...
            InertMass(8), InertMass(9), 0, InertMass(10), ...
            0, InertMass(11), ...
            0, InertMass(1), InertMass(2), InertMass(3));
    elseif (stage == 2 && strcmp(propellant_names, "Solid"))
        fprintf(displayString, ...
            stage, chiValues(k), Mpr0(stage), deltaValues(k), ...
            InertMass(2), InertMass(3), ...
            0, InertMass(5), InertMass(4), InertMass(6), ...
            S2Avionics, InertMass(7), ...
            InertMass(1), 0, 0, 0);
    elseif (stage == 2 && strcmp(propellant_names, "else"))
        fprintf(displayString, ...
            stage, chiValues(k), Mpr0(stage), deltaValues(k), ...
            InertMass(3)+InertMass(4), InertMass(5)+InertMass(6), ...
            InertMass(7), InertMass(8), 0, InertMass(9), ...
            S2Avionics, InertMass(10), ...
            InertMass(1), InertMass(2), 0, 0);
    end
    cost = stageCost(sum(InertMass));
    fprintf("Stage Cost: %d\n\n", cost);
    costSum = costSum + cost;
end
    fprintf("Vehicle Cost: %d\n\n", costSum);
end