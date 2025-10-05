function [h] =findTankHeight(propMass,r,rho)
    %Find height of the tank cylinder based on propellant mass and radius
    volume= findVolume(propMass,rho);
    h = (3*volume-4*pi*(r^3)) / (3*pi*(r^2));
end