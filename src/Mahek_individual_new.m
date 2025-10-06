% Submission 1 Template, Group 1

close all;
clear;
clc;
% Givens
delta_v = 12.3; % km/s
m_pl = 26000; % kg
delta = 0.08; % Inert mass fraction for both stages
chi = 0.2:0.01:0.8; %array
Isp1 = 269; % s, 1st stage, LOX/CH4
%       LOX/CH4 LOX/LH2 LOX/RP1 Solid   Storables
Isp2 = [327,    366,    311,    269,    285]; % s, 2nd stage
stage1Prop = "Solid";
stage2Prop = ["LOX/CH_4", "LOX/LH_2", "LOX/RP1", "Solid", "Storables"];


for k=1:length(Isp2)
    [M01_array, M02_array, chi_array] = getMass(delta_v,m_pl,delta,chi,Isp1,Isp2(k));
    [m_pr1, m_pr2] = propMass(delta, M01_array, M02_array, m_pl);
    [m_in1, m_in2] = inertMass(delta, M01_array, M02_array);
    Mo = M01_array + M02_array;

    M01_array = M01_array./1000;
    M02_array = M02_array./1000;
    Mo = Mo./1000;

    [minMass, mIndex] = findMinMass(Mo);
    minMass
    costForMinMassS1 = stageCost(m_in1(mIndex));
    costForMinMassS2 = stageCost(m_in2(mIndex));
    costForMinMass = costForMinMassS1 + costForMinMassS2
    costS1 = stageCost(m_in1);
    costS2 = stageCost(m_in2);
    costTotal = costS1 + costS2;
    [minCost, cIndex] = findMinCost(costTotal);
    minCost
    massForMinCost = Mo(cIndex)
    
    l = floor(length(chi_array)/4);
    mStart = max(mIndex - l, 1);
    mEnd = min(mIndex + l, length(chi_array));
    cStart = max(cIndex - l, 1);
    cEnd = min(cIndex + l, length(chi_array));
    figure(k)
    hold on;
    grid on;
    plot(chi_array(mStart:mEnd), M02_array(mStart:mEnd));
    plot(chi_array(mStart:mEnd), M01_array(mStart:mEnd));
    plot(chi_array(mStart:mEnd), Mo(mStart:mEnd));
    plot(chi_array(mIndex), minMass, "o");
    legend ('M_{02}', 'M_{01}', 'M_0', "M_{min}");
    titleMass = sprintf("Total Masses vs. Chi (S1: %s, S2: %s)", stage1Prop, stage2Prop(k));
    title(titleMass);
    ylabel('Mass (tonnes)');
    xlabel('Chi');

    figure(length(Isp2) + k)
    hold on;
    grid on;
    plot(chi_array(cStart:cEnd), costS2(cStart:cEnd));
    plot(chi_array(cStart:cEnd), costS1(cStart:cEnd));
    plot(chi_array(cStart:cEnd), costTotal(cStart:cEnd));
    plot(chi_array(cIndex), minCost, "o");
    legend ('Cost_2', 'Cost_1', 'Cost_0', "Cost_{min}");
    titleMass = sprintf("Cost vs. Chi (S1: %s, S2: %s)", stage1Prop, stage2Prop(k));
    title(titleMass);
    ylabel('Cost ($M)');
    xlabel('Chi');

end