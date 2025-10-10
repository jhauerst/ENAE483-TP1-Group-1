function [ Mo_min, Min1_min,Min2_min,Mo1_min, Mo2_min,Mpr1_min,Mpr2_min,chi_min] = submission1 (delta, Propellantstage1, Propellantstage2, newChi)
% Joseph and Emma mainly worked on this code
% Givens
delta_v = 12.3; % km/s
m_pl = 26000; % kg
chi = 0.2:0.01:0.8; % array
Isp = [327,    366,    311,    269,    285]; 
propNames = ["LOX/LCH4" "LOX/LH2" "LOX/RP1" "Solid" "Storables"];
for i = 1:length(propNames) %run through all propellant names 
     %select Isp based on prop. name and stage
    if strcmp(Propellantstage1, propNames(i))
         Isp1 = Isp(i);
    end
     if strcmp(Propellantstage2, propNames(i))
         Isp2 = Isp(i);
    end
end

    if (newChi == 0)
    [M01_array, M02_array, chi_array] = getMass(delta_v,m_pl,delta,chi,Isp1,Isp2); %getting stage mass for all chi values
    [m_pr1, m_pr2] = propMass(delta, M01_array, M02_array, m_pl); %propellant mass for both stages
    [m_in1, m_in2] = inertMass(delta, M01_array, M02_array); %inert mass for both stages
    Mo = M01_array + M02_array; %total initial mass
    %calculate stage cost based on intert mass

    costS1 = stageCost(m_in1);
    costS2 = stageCost(m_in2);
    costTotal = costS1 + costS2;
    [~, cIndex] = findMinCost(costTotal); %finding the minimum of the costs

    %getting all the minimum cost points for the different mass parameters
    Mo_min = Mo(cIndex);
    Min1_min = m_in1(cIndex);
    Min2_min = m_in2(cIndex);
    Mo1_min = M01_array(cIndex);
    Mo2_min = M02_array(cIndex);
    Mpr1_min = m_pr1(cIndex);
    Mpr2_min = m_pr2(cIndex);
    chi_min = chi_array(cIndex);
    else
    [M01_array, M02_array, chi_array] = getMass(delta_v,m_pl,delta,[newChi],Isp1,Isp2); %getting stage mass for all chi values
    [m_pr1, m_pr2] = propMass(delta, M01_array, M02_array, m_pl); %propellant mass for both stages
    [m_in1, m_in2] = inertMass(delta, M01_array, M02_array); %inert mass for both stages
    Mo = M01_array + M02_array; %total initial mass

    %getting all the minimum cost points for the different mass parameters
    Mo_min = Mo(1);
    Min1_min = m_in1(1);
    Min2_min = m_in2(1);
    Mo1_min = M01_array(1);
    Mo2_min = M02_array(1);
    Mpr1_min = m_pr1(1);
    Mpr2_min = m_pr2(1);
    chi_min = chi_array(1);
    end
end