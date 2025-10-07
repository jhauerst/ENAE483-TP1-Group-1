%% Main Section Code for 2.1

% Array guide for subsystem masses: 
% 1 --> if i = 1 , propellant_name = "Solid" : totalMass1 = [Interstage Aft1 propellantTank insul_solid engineMass1 structureMass1 gimbalsMass1 wiringMass1 avionicsMass1];
% 2 --> if i = 1 , propellant_name = "else" : totalMass1 = [Intertank1 Interstage Aft1 fuel_tank1 oxidizer_tank1 insul_oxid1 insul_fuel1 engineMass1 structureMass1 gimbalsMass1 wiringMass1 avionicsMass1 ];
% 3 --> if i = 2 , propellant_name = "Solid" : totalMass2 = [Payload2 propellantTank2 insul_solid2 engineMass2 structureMass2 gimbalsMass2 wiringMass2];
% 4 --> if i = 2 , propellant_name = "else" : totalMass2 = [payload2 Intertank2 fuel_tank2 oxidizer_tank2 insul_oxid2 insul_fuel2 engineMass2 structureMass2 gimbalsMass2 wiringMass2];

clear; clc; close all;
%propNames = ["LOX/LCH4" "LOX/LH2" "LOX/RP1" "Solid" "Storables"];
propNames = ["LOX/RP1" "Storables"];
Propellantstage1 = "LOX/LH2"; % user changed

h = 4; % meters, we decided as a team vote
chi1 = 0.54 ; % min mass soln
chi2 = 0.53 ; % min cost soln
delta = 0.08;

vehicleParamsSize = 7; % if you add a vehicleParam later, change this number
allOptimizedVehicles = zeros(length(propNames)*2,vehicleParamsSize);
for k = 1:length(propNames)     % Going through all the propellant names/combinations

    firstIteration = true;
    mass_margin = 0;

    while mass_margin < 0.3      % This is to update the delta, if it is not the first iteration, until a mass margin of 30% is achieved
        
        if ~ firstIteration 
            delta = delta + 0.01;  
        else
            firstIteration = false;
        end
        
        Propellants = [Propellantstage1, propNames(k)]     % user's specific propellant combination
        [ Mo_min, Min1_min,Min2_min,Mo1_min, Mo2_min,Mpr1_min,Mpr2_min] = submission1 (delta, Propellantstage1, propNames(k)); % Grab submission 1 masses

        vehicle_inertMass1 = Min1_min + Min2_min;
        m0 = [Mo_min, Mo2_min];     % stage 1 and 2 array
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
                Mpr0(i)
                radius
                Propellants(i)
                [height, fuelh, h_oxidizer, ratio, rho] = findTankHeight(Mpr0(i),radius, Propellants(i))  % new height based on new radius
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
            currentInertMass = InertMass;  
             
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
            
            vehicleParams(stage,:) = [minEngines min_radius min_height minInertmass Mpr0(stage) m0(stage) thrust_weight_ratio(stage)]
            
        end
        
        allOptimizedVehicles(2*k-1:2*k, :) = vehicleParams;
        mass_margin = (vehicle_inertMass1 - vehicle_inertMass2)/(vehicle_inertMass2)  % calculate the mass margin
    
    end % end of while loop 

    mass_margin = (vehicle_inertMass1 - vehicle_inertMass2)/(vehicle_inertMass2);  % calculate the mass margin
   end % end of while loop 

   % get all the masses
[minInertMass, i, propellant_names] = totalInertMass(minStageArray,stage2_array,Propellants(stage),m0(stage),h,stage);

% rerun the functions
% need to output individual subsystems and corresponding stage 1
% output individual subsystems and corresponding stage 2
% total LV mass sums

end

for k=1:(length(allOptimizedVehicles(:,1))/2)
    disp(Propellantstage1 + ", " + propNames(k))
    for l=0:1
        index = 2*k+l-1;
    fprintf("Stage: %d \tEngines: %d \tRadius: %f \tHeight: %f \tInert Mass: %d \t\nPropellant Mass: %d \tInitial Stage Mass: %d \tTWR: %d\n\n", ...
        l+1, ...
        allOptimizedVehicles(index, 1), ...
        allOptimizedVehicles(index, 2), ...
        allOptimizedVehicles(index, 3), ...
        allOptimizedVehicles(index, 4), ...
        allOptimizedVehicles(index, 5), ...
        allOptimizedVehicles(index, 6), ...
        allOptimizedVehicles(index, 7))
    end
end