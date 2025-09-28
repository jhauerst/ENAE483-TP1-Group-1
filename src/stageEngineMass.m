function [engineMass, structureMass, gimbalsMass] = stageEngineMass(m0, mProp, TWR, P0, expanRatio, nEngines, type)
    g = 9.81;
    Treq = m0 * g * TWR/nEngines;

    structureMass = 2.55*10^-4*Treq;
    gimbalsMass = 237.8*(Treq/P0)^0.9375;

    if strcmp(type, "LOX/LH2") || strcmp(type, "LOX/LCH4") || strcmp(type, "LOX/RP1") || strcmp(type, "Storables")
        engineMass = 7.81*10^-4*Treq + 3.37*10^-5*Treq*sqrt(expanRatio) + 59;
    end
    if strcmp(type, "Solid")
        engineMass = 0.135*mProp;
    end
end