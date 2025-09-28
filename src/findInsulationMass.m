%% Find Tank 
function InsMass = findInsulationMass(AT,fuelname)
    if strcmp(fuelname, "LH2")
        InsMass = 2.88*AT; 
    else 
        InsMass = 1.123*AT;
    end
end

    