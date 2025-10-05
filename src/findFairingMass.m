function [Payload, Intertank, Aft] = findFairingMass(r, rt1, rt2,h)
%% Call this function twice for each stage
%h: height of stage
%rt1: Radius of the fule tank
%rt2: Radius of the oxidizer tank
%r: Radius of stage 
%Assume inter-stage fairing is equal to aft fairing for the second stage.
A_cone = pi*r*sqrt(r^2 + h^2); %Area for the payload fairing
A_frustrum = pi*(rt1 + rt2)*sqrt((rt1-rt2)^2+h^2);%Area for inter-tank fairing
A_cylinder = 2*pi*r*(h+3); % leave sufficient engine fairing below propellant tanks (3m)
%caluclate fairing masses 
Payload = 4.95*(A_cone)^1.15;%Only for 2nd stage
Intertank = 4.95*(A_frustrum)^1.15;%one inter-tank fairng per stage
Aft = 4.95*(A_cylinder)^1.15;%Aft fairing of 2nd stage = Inter-stage fairing
end

