function [nEngines, diameter_ofthrust] = EngineDimension(stage,m0,prop) % type of propellant
    propNames = ["LOX/LCH4" "LOX/LH2" "LOX/RP-1" "Solid" "Storables"];   
    i = find(propNames==prop) ;    
    g = 9.81;
    TWR = [1.3 0.76];
    Treq = [2.26 1.86 1.92 4.5 1.75; 0.745 0.99 0.61 2.94 0.67];
    nEngines = (Treq(stage,i)/(m0*g*TWR(stage)))^-1;  
    nEngines = ceil(nEngines);
    D_engine = [2.4 2.4 3.7 6.6 1.5; 1.5 2.15 0.92 2.34 1.13];
    diameter = D_engine(stage, i);
    [radius_ofthrust] = RocketDiameter (nEngines,diameter);
    diameter_ofthrust = radius_ofthrust*2;
end