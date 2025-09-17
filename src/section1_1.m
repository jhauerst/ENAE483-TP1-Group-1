%% Section 1.1
close all;
clear;
clc;
%Givens
delta_v = 12.3; %km/s
m_pl = 26000; %kg
delta = 0.08; %Inert mass fraction for both stages
chi = 0.01:0.01:0.99; %array
Isp1 = 366; %s (for LOX/LH2)
Isp2 = 366; %s (for LOX/LH2)
% Equations 

[M01_array, M02_array, chi_array] = getMass(delta_v,m_pl,delta,chi,Isp1,Isp2);

figure (1)
plot(chi_array, M02_array)
hold on
grid on
plot(chi_array, M01_array)
plot(chi_array,M01_array+M02_array)
legend ('M02', 'M01', 'M0')
hold off
title('Total Masses vs. Chi')
ylabel('Mass (kg)')
xlabel('Chi')


[m_pr1, m_pr2] = propMass(delta,M01_array,M02_array, m_pl);
figure(2)
subplot(2,1,1)
plot(M01_array,m_pr1)
grid on
title('M01 vs. M_pr1')
ylabel('Mass (kg)')
xlabel('Mass (kg)')
subplot(2,1,2)
plot(M02_array,m_pr2)
title('M02 vs. M_pr2')
ylabel('Mass (kg)')
xlabel('Mass (kg)')
grid on



        