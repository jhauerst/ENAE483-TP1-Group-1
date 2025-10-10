function [h_total, fuel_height, oxidizer_height, ratio, rho, r] =findTankHeight(Mpr0,r, Propellant)
%Mpr0: Overall Propellant mass (kg)
%r: 
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
        %Replace formula below 
        if Propellant == "Solid"
            h = volume/(pi*r^2);
            r = 0;
        else
            h = max((volume-4*(pi/3)*r^3) / (pi*r^2), 0);
            if h == 0 
                r = (3*volume/(4*pi))^(1/3);
            end
        end

        heights(end+1) = h+2*r;
        h_total = h+h_total+2*r;
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