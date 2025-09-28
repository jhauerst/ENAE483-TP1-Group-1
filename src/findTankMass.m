%% FIND Mass of the Tank
function M_tank = findTankMass(Mpr,fuelname,Vpr)
    if strcmp(fuelname, "LOX") %LOX
        M_tank = 0.0107*Mpr;
    elseif strcmp(fuelname, "LH2") %LH2
        M_tank = 0.128*Mpr;
    elseif strcmp(fuelname, "RP-1") %RP-1
        M_tank = 0.0148*Mpr;
    elseif strcmp(fuelname, "LCH4") %LCH4
        M_tank = 0.0287*Mpr;
    else  %N2O4, UDMH, Solid
        M_tank =12.16*Vpr;
    end
end
