propNames = ["LOX/LCH4" "LOX/LH2" "LOX/RP-1" "Solid" "Storables"];
chi1 = 0.54 ; % min mass soln
chi2 = 0.53 ; % min cost soln
delta = 0.08;

previous_radius = 1000;
for k = 1:length(propNames)
    firstIteration = true;
   while mass_margin < 0.3 
       if ~ firstIteration 
        delta = delta + 0.01;
       else
        firstIteration = false;
       end

    Propellants = ["LOX/RP-1", propNames(k)];
    % call submission 1
    m0 = [m0, array(k)]; % fix later
    %mass of current propellant
    vehicle_inertMass2 = 0;
        for i=2:-1:1
        stage = i;
        [nEngines, diameter_ofthrust] = EngineDimension(stage, m0(stage), Propellants(stage));
        radius = diameter_ofthrust/2;
        % height function goes here
        min_radius = 1000;
        % minInertmass = high value
            while radius < height
            radius = radius + 0.1;
            % height function based on new radius
            L = height;
            D = radius*2;
                if L/D > 13 && radius < previous_radius % if condition not met then skip to the next iteration
                    continue
                end    
    
            currentInertMass = Inertmassfunction;
            % inert mass function 
                if currentInertMass < minInertmass   % check for new minimum inert mass
                min_radius = radius;
                min_height = height;
                minInertmass = currentInertMass;
                end
            end
        previous_radius = min_radius;
        vehicle_inertMass2 = minInertmass + vehicle_inertMass;
        end

    mass_margin = (vehicle_inertMass1 - vehicle_inertMass2)/(vehicle_inertMass2);
   end % end of while loop


end


