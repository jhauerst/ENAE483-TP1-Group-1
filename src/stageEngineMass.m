function [engineMass, structureMass, gimbalsMass] = stageEngineMass(m0, mProp, TWR, type, nEngine, stageNum)
    %m0: total mass per stage (kg)
    %mprop: propellant mass per stage (kg)
    %TWR: thrust to weight ratio
    %Type: propellant name (fuel/oxidizer)
    %nEngine: number of engines
    %stageNum: stage number 
    g = 9.81;
    propNames = {'LOX/LCH4','LOX/LH2','LOX/RP1','Solid','Storables'};
    % arrays of thrust, chamber pressure, and expansion ratios per stage per
    % propellant
    s1Thrust = [2.26e+6, 1.86e+6, 1.92e+6, 4.5e+6, 1.75e+6]; 
    s2Thrust = [0.745e+6, 0.099e+6, 0.061e+6, 2.94e+6, 0.067e+6];
    s1Pressure = [35.16e+6, 20.64e+6, 25.8e+6, 10.5e+6, 15.7e+6];
    s2Pressure = [10.1e+6, 4.2e+6, 6.77e+6, 5e+6, 14.7e+6];
    s1ExpantionRatio = [34.34, 78, 37, 16, 26.2];
    s2ExpantionRatio = [45, 84, 14.5, 56, 81.3];
    %Loop through propellant names and find values based on propellant pick
    for i = 1:length(propNames)
        if strcmp(type, propNames(i))
            if stageNum == 1
                TPerEngine = s1Thrust(i);
                P0 = s1Pressure(i);
                expanRatio = s1ExpantionRatio(i);
            end
            if stageNum == 2
                TPerEngine = s2Thrust(2);
                P0 = s2Pressure(i);
                expanRatio = s2ExpantionRatio(i);
            end
        end
    end
    T_total = TWR * m0 * g;%Total thrust (N)
    structureMass = 2.55*10^-4*T_total;%overall structure mass
    gimbalsMass = nEngine*(237.8*(TPerEngine/P0)^0.9375);%Gimbal mass per engine

    if strcmp(type, "LOX/LH2") || strcmp(type, "LOX/LCH4") || strcmp(type, "LOX/RP1") || strcmp(type, "Storables")
        engineMass = 7.81*10^-4*TPerEngine + 3.37*10^-5*TPerEngine*sqrt(expanRatio) + 59;% Engine mass
        engineMass = nEngine*engineMass;
    end
    if strcmp(type, "Solid")
        engineMass = 0.135*mProp;
    end

end