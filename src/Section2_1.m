%% Main Section Code for 2.1

propNames = ["LOX/LCH4" "LOX/LH2" "LOX/RP-1" "Solid" "Storables"];
Propellantstage1 = "Solid"; % user changed

chi1 = 0.54 ; % min mass soln
chi2 = 0.53 ; % min cost soln
delta = 0.08;

previous_radius = Inf;
for k = 1:length(propNames)     % Going through all the propellant names/combinations
    firstIteration = true;
   while mass_margin < 0.3      % This is to update the delta, if it is not the first iteration, until a mass margin of 30% is achieved
       if ~ firstIteration 
        delta = delta + 0.01;  
       else
        firstIteration = false;
       end

    Propellants = [Propellantstage1, propNames(k)];     % user's specific propellant combination
    [ Mo_min, Min1_min,Min2_min,Mo1_min, Mo2_min,Mpr1_min,Mpr2_min] = submission1 (delta, Propellantstage1, propNames(k)); % Grab submission 1 masses
    m0 = [Mo_min, Mo2_min];     % stage 1 and 2 array
    Mpr0 = [Mpr1_min Mpr2_min]; % stage 1 and 2 array
    vehicle_inertMass2 = 0;
        for i=2:-1:1    % start with stage 2 and go to stage 1
        stage = i;
        [nEngines, diameter_ofthrust] = EngineDimension(stage, m0(stage), Propellants(stage));  % find number of engines and diameter of all those engines
        radius = diameter_ofthrust/2;
        [h_total] = findTankHeight(Mpr0(i),radius, Propellants(i));     % function to find height of tank
        min_radius = Inf;   % intializing variable, high number
        minInertmass = Inf; % intializing variable, high number
            while radius < height  % constraint
            radius = radius + 0.1; % keep increasing radius until constraint is met
            [h_total] = findTankHeight(Mpr0(i),radius, Propellants(i));  % new height based on new radius
            L = height;
            D = radius*2;
                if L/D > 13 && radius < previous_radius && radius < 5.3 % if condition not met then skip to the next iteration
                    continue
                end    
    
            currentInertMass = Inertmassfunction;  
            % inert mass function 
                if currentInertMass < minInertmass   % check for new minimum inert mass
                min_radius = radius;                 % new minimum radius
                min_height = height;                 % new minimum height
                minInertmass = currentInertMass;     % new minimum inert mass
                end
            end
        previous_radius = min_radius;       % update the previous radius
        vehicle_inertMass2 = minInertmass + vehicle_inertMass;      % add the inert masses
        end

    mass_margin = (vehicle_inertMass1 - vehicle_inertMass2)/(vehicle_inertMass2);  % calculate the mass margin
   end % end of while loop 

   % get all the masses

mass_margin
vehicle_inertMass2
end


