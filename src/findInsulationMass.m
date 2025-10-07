%% Find Tank Insulation
function InsMass = findInsulationMass(AT,fuelname) %exposed surface area of tank, fuel name
    if strcmp(fuelname, "LH2")
        InsMass = 2.88*AT; 
    elseif strcmp(fuelname, "LCH4") || strcmp(fuelname, "LOX")
        InsMass = 1.123*AT;
    else
        InsMass = 0;
    end
end

    