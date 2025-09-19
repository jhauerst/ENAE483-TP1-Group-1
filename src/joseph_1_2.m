% Section 1.2, Joseph Hauerstein

close all;
clear;
clc;
% Givens
delta_v = 12.3; % km/s
m_pl = 26000; % kg
delta = 0.08; % Inert mass fraction for both stages
chi = 0.2:0.01:0.8; %array
Isp1 = 327; % s, 1st stage, LOX/CH4
%       LOX/CH4 LOX/LH2 LOX/RP1 Solid   Storables
Isp2 = [327,    366,    311,    269,    285]; % s, 2nd stage
stage1Prop = "LOX/CH_4";
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
    
    l = round(length(chi_array)/4);
    figure(k)
    hold on;
    grid on;
    plot(chi_array(mIndex-l:mIndex+l), M02_array(mIndex-l:mIndex+l));
    plot(chi_array(mIndex-l:mIndex+l), M01_array(mIndex-l:mIndex+l));
    plot(chi_array(mIndex-l:mIndex+l), Mo(mIndex-l:mIndex+l));
    plot(chi_array(mIndex), minMass, "o");
    legend ('M_{02}', 'M_{01}', 'M_0', "M_{min}");
    titleMass = sprintf("Total Masses vs. Chi (S1: %s, S2: %s)", stage1Prop, stage2Prop(k));
    title(titleMass);
    ylabel('Mass (tonnes)');
    xlabel('Chi');

    figure(length(Isp2) + k)
    hold on;
    grid on;
    plot(chi_array(cIndex-l:cIndex+l), costS2(cIndex-l:cIndex+l));
    plot(chi_array(cIndex-l:cIndex+l), costS1(cIndex-l:cIndex+l));
    plot(chi_array(cIndex-l:cIndex+l), costTotal(cIndex-l:cIndex+l));
    plot(chi_array(cIndex), minCost, "o");
    legend ('Cost_2', 'Cost_1', 'Cost_0', "Cost_{min}");
    titleMass = sprintf("Cost vs. Chi (S1: %s, S2: %s)", stage1Prop, stage2Prop(k));
    title(titleMass);
    ylabel('Cost ($M)');
    xlabel('Chi');

end