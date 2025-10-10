function [Payload, Intertank1 ,Intertank2 , Interstage, Aft] = findFairingMass(rs1, rs2,h)
%% Call this function twice for each stage
% Abdullah mainly worked on this code
%rs1: Radius of 1st stage
%rs2: Radius of 2nd stage 
%h: height of aerodynamic cone

A_cone = pi*rs2*sqrt(rs2^2 + h^2); %Area for the aerodynamic fairing 
A_cylinder_payload = 2*pi*rs2*(13); %Area for payload cylinder
A_payload = A_cone + A_cylinder_payload; %Total area of payload fairing 
A_frustrum = pi*(rs1 + rs2)*sqrt((rs1-rs2)^2+(rs1+rs2+3)^2);%Area for inter-stage fairing

% leave sufficient engine fairing below propellant tanks (3m)
A_cylinder1 = 2*pi*rs1*(2*rs1); %Area for inter-tank fairing, stage 1
A_cylinder2 = 2*pi*rs2*(2*rs2); %Area for inter-tank fairing, stage 2
A_aft = 2*pi*rs1*(rs1+3); %Area for aft fairing

%caluclate fairing masses 
Payload = 4.95*(A_payload)^1.15;%Only for 2nd stage
Intertank1 = 4.95*(A_cylinder1)^1.15; %Inter-tank fairng for 1st stage
Intertank2 = 4.95*(A_cylinder2)^1.15; %Inter-tank fairng 2nd stage
Interstage = 4.95*(A_frustrum)^1.15; %One inter-stage fairing
Aft = 4.95*(A_aft)^1.15;%Aft fairing of 2nd stage = Inter-stage fairing
end

