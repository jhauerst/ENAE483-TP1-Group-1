%% Main Section Code for 2.1
clear; clc; close all;
propNames = ["LOX/LCH4" "LOX/LH2" "LOX/RP1" "Solid" "Storables"];
Propellantstage1 = "LOX/LH2"; % user changed

h = 4; % meters, we decided as a team vote
chi1 = 0.54 ; % min mass soln
chi2 = 0.53 ; % min cost soln
delta = 0.08;

previous_stage = [];
previous_radius = Inf;
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
        for i=2:-1:1    % start with stage 2 and go to stage 1
        stage = i;
        [nEngines, diameter_ofthrust] = EngineDimension(stage, m0(stage), Propellants(stage));  % find number of engines and diameter of all those engines
        radius = diameter_ofthrust/2;
        [height, fuelh, h_oxidizer, ratio, rho] = findTankHeight(Mpr0(i),radius, Propellants(stage));     % function to find height of tank
        min_radius = Inf;   % intializing variable, high number
        minInertmass = Inf; % intializing variable, high number
            while radius < height  % constraint
            radius = radius + 0.1; % keep increasing radius until constraint is met
            [height, fuelh, h_oxidizer, ratio, rho] = findTankHeight(Mpr0(i),radius, Propellants(i));  % new height based on new radius
            L = height;
            D = radius*2;
                if L/D > 13 && radius < previous_radius && radius < 5.3 % if condition not met then skip to the next iteration
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
            [InertMass] = totalInertMass(stage1_array,stage2_array,Propellants(stage),m0(stage),h,stage);
            currentInertMass = InertMass;  
             
                if currentInertMass < minInertmass   % check for new minimum inert mass
                min_radius = radius;                 % new minimum radius
                min_height = height;                 % new minimum height
                minInertmass = currentInertMass;     % new minimum inert mass
                end
            end
        previous_radius = min_radius;       % update the previous radius
        vehicle_inertMass2 = minInertmass + InertMass;      % add the inert masses
        previous_stage = stageArray;
        end

    mass_margin = (vehicle_inertMass1 - vehicle_inertMass2)/(vehicle_inertMass2);  % calculate the mass margin
   end % end of while loop 

   % get all the masses

mass_margin
vehicle_inertMass2
end


