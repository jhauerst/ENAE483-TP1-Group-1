function [Payload, Intertank, Interstage, Aft] = findFairingMass(r, rf1, rf2,h)
A_cone = pi*r*sqrt(r^2 + h^2);
A_frustrum = pi*(rf1 + rf2)*sqrt((rf1-rf2)^2+h^2);
A_cylinder = 2*pi*r*(h+3); % leave sufficient engine fairing below propellant tanks (3m)
Payload = 4.95*(A_cone)^1.15;
Intertank = 4.95*(A_frustrum)^1.15;
Interstage = 4.95*(A_frustrum)^1.15;
Aft = 4.95*(A_cylinder)^1.15;
end

