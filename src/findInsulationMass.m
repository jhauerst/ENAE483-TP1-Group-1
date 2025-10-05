%% Find Tank Insulation
function InsMass = findInsulationMass(AT,fuelname) %exposed surface area of tank, fuel name
    if strcmp(fuelname, "LH2")
        InsMass = 2.88*AT; 
    else 
        InsMass = 1.123*AT;
    end
end

    