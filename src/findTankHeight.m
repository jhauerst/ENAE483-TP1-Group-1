function [h_total, fuel_height, oxidizer_height, ratio, rho] =findTankHeight(Mpr0,r, Propellant) 
    % Find height of the tank cylinder based on propellant mass and radius
density = [71 1140 820 423 1680 1442 791]; % LH2 LOX RP-1 LCH4 APCP(solid) N2O4 UDMH
% NOTE: propMass must include oxidizer first
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
elseif Propellant == "LOX/RP1"
    rho = [density(2) density(3)];
    ratio = [2.72 1];
    [oxidizer_mass, fuel_mass] = findFuelMass(Mpr0, ratio);
    propMass = [oxidizer_mass, fuel_mass];
elseif Propellant == "Solid"
    ratio = [1 0];
    rho = [density(5) 0];
    propMass = Mpr0;
elseif Propellant == "Storables"
    rho = [density(6) density(7)];
    ratio = [2.67 1];
    [oxidizer_mass, fuel_mass] = findFuelMass(Mpr0, ratio);
    propMass = [oxidizer_mass, fuel_mass];
end

h_total = 0;
heights = [];
    for i = 1:length(propMass)
        volume = findVolume(propMass(i),rho(i));
        %volume for cylinder with hemispherical caps
        h = (3*volume-4*pi*(r^3)) / (3*pi*(r^2));
        heights(end+1) = h;
        h_total = h+h_total;
    end
    if Propellant == "Solid"
        ratio = [0 1];
        rho = [0 density(5)];
    end
    if (length(heights) == 2)
        oxidizer_height = heights(1);
        fuel_height = heights(2);
    elseif (length(heights) == 1)
        fuel_height = heights(1);
        oxidizer_height = 0;
    end
end