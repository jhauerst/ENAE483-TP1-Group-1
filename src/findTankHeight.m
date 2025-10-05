function [h_total] =findTankHeight(Mpr0,r, Propellant) 
    % Find height of the tank cylinder based on propellant mass and radius
density = [71 1140 820 423 1680 1442 791]; % LH2 LOX RP-1 LCH4 APCP(solid) N2O4 UDMH
if Propellant == "LOX/LCH4" 
    rho = [density(2) density(4)];
    ratio = [3.6 1];
    [oxidizer_mass, fuel_mass] = findFuelMass(Mpr0, ratio);
    propMass = [oxidizer_mass, fuel_mass];
elseif Propellant == "LOX/LH2" 
    rho = [density(2) density(1)];
    ratio = [6.03 1];
    [oxidizer_mass, fuel_mass] = findFuelMass(Mpr0, ratio);
    propMass = [oxidizer_mass, fuel_mass];
elseif Propellant == "LOX/RP-1"
    rho = [density(2) density(3)];
    ratio = [2.72 1];
    [oxidizer_mass, fuel_mass] = findFuelMass(Mpr0, ratio);
    propMass = [oxidizer_mass, fuel_mass];
elseif Propellant == "Solid"
    rho = [density(5)];
    propMass = Mpr0;
elseif Propellant == "Storables"
    rho = [density(6) density(7)];
    ratio = [2.67 1];
    [oxidizer_mass, fuel_mass] = findFuelMass(Mpr0, ratio);
    propMass = [oxidizer_mass, fuel_mass];
end

h_total = 0;
    for i = 1:length(rho)
        volume = findVolume(propMass(i),rho(i));
        h = (3*volume-4*pi*(r^3)) / (3*pi*(r^2));
        h_total = h+h_total;
    end
end