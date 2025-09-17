%% Individual work for section 1.2, Abdullah Alnamlah
close all;
clear;
clc;

% Propellant Mixtures
Isp1 = 311; %s LOX/RP1
Isp2_array = [327, 366, 311, 269, 285]; %s LOX/LCH4 LOX/LH2, LOX/RP1, Solid, Storables
secondStageNames = {'LOX/LCH4','LOX/LH2','LOX/RP1','Solid','Storables'};

% Other Parameters
delta_v = 12.3; %km/s
m_pl = 26000; %kg
delta = 0.08; %Inert mass fraction for both stages
chi = 0.01:0.01:0.99; %array

for k = 1:length(Isp2_array)
    Isp2 = Isp2_array(k);
    [M01_array, M02_array, chi_array] = getMass(delta_v,m_pl,delta,chi,Isp1,Isp2);
    M0_array = M01_array +M02_array;
    [M0_min, index] = findMinMass(M0_array); %Get minimum Gross Mass
    chi_min = chi_array(index);
    
    %section out the chi values for mass plots
    l= round(length(chi_array)/4);
    lower_bound = index - l;
    upper_bound = index + l;

    %Cost 
    [m_inrt1, m_inrt2] = inertMass(delta, M01_array, M02_array);
    cost1 = stageCost(m_inrt1);
    cost2 = stageCost(m_inrt2);
    total_cost = cost1 + cost2;
    [min_total_cost, index2] = findMinCost(total_cost);
    chi_min2 = chi_array(index2);
    %section out the chi values for cost plots
    lower_bound2 = index2 - l;
    upper_bound2 = index2 + l;


    %Plot for 1.2
    figure(k)
    plot(chi_array(lower_bound:upper_bound), M01_array(lower_bound:upper_bound)/1000);
    hold on
    plot(chi_array(lower_bound:upper_bound), M02_array(lower_bound:upper_bound)/1000);
    plot(chi_array(lower_bound:upper_bound), M0_array(lower_bound:upper_bound)/1000);
    plot(chi_min, M0_min/1000, 'ro', 'MarkerFaceColor','r', 'MarkerSize',8);
    grid on
    legend ('M01', 'M02', 'M0')
    xlabel('First stage delta_v fraction')
    ylabel('Mass (tons)')
    title(sprintf('First stage: LOX/RP1 (%d s)  —  Second stage: %s (%d s)', ...
        Isp1, secondStageNames{k}, Isp2), 'Interpreter','none');
       
    %Plot for 1.3
    figure(5+k)
    plot(chi_array(lower_bound2:upper_bound2), cost1(lower_bound2:upper_bound2));
    hold on
    plot(chi_array(lower_bound2:upper_bound2), cost2(lower_bound2:upper_bound2));
    plot(chi_array(lower_bound2:upper_bound2), total_cost(lower_bound2:upper_bound2));
    plot(chi_min2, min_total_cost, 'ro', 'MarkerFaceColor','r', 'MarkerSize',8);
    grid on
    legend ('stage 1', 'stage 2', 'vehicle')
    xlabel('First stage delta_v fraction')
    ylabel('Cost ($ Millions)')
    title(sprintf('First stage: LOX/RP1 (%d s)  —  Second stage: %s (%d s)', ...
        Isp1, secondStageNames{k}, Isp2), 'Interpreter','none');

end
 
