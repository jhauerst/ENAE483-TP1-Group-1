function [mass_total_inert]=totalInertMass(rf1,rf2,h,fuelname)
    [~, ~, ~, ~,TotalFairingMass] = findFairingMass(r, rf1, rf2,h);
    AT=2*pi*rf1*h+2*pi*rf1^2;
    [InsMass] = findInsulationMass(AT,fuelname);
    mass_total_inert = TotalFairingMass;
end