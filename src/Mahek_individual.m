%% Section 1.1
%% Solid & LOX/LCH4
close all;
clear;
clc;
%Givens
delta_v = 12.3; %km/s
m_pl = 26000; %kg
delta = 0.08; %Inert mass fraction for both stages
chi = 0.01:0.01:0.99; %array
Isp1 = 269; %s (for solid)
Isp2 = 327; %s (for LOX/LH4)
% Equations 

[M01_array, M02_array, chi_array] = getMass(delta_v,m_pl,delta,chi,Isp1,Isp2);
M01_array=M01_array/1000;
M02_array=M02_array/1000;
Mos=M01_array+M02_array;
[mass, index] = findMinMass(Mos)
l=round(length(chi_array)/4);

figure (1)
plot(chi_array(index-l:index+l), M02_array(index-l:index+l))
hold on
grid on
plot(chi_array(index-l:index+l), M01_array(index-l:index+l))
plot(chi_array(index-l:index+l),Mos(index-l:index+l))
plot(chi_array(index),mass,'o')
legend ('M02', 'M01', 'M0')
hold off
title('Solid & LOX/LC2')
ylabel('Mass (metric tons)')
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

%% Solid & LOX/LH2
close all;
clear;
clc;
%Givens
delta_v = 12.3; %km/s
m_pl = 26000; %kg
delta = 0.08; %Inert mass fraction for both stages
chi = 0.01:0.01:0.99; %array
Isp1 = 269; %s (for solid)
Isp2 = 366; %s (for LOX/LH2)
% Equations 

[M01_array, M02_array, chi_array] = getMass(delta_v,m_pl,delta,chi,Isp1,Isp2);
M01_array=M01_array/1000;
M02_array=M02_array/1000;
Mos=M01_array+M02_array;
[mass, index] = findMinMass(Mos)
l=round(length(chi_array)/4);

figure (1)
plot(chi_array(index-l:index+l), M02_array(index-l:index+l))
hold on
grid on
plot(chi_array(index-l:index+l), M01_array(index-l:index+l))
plot(chi_array(index-l:index+l),Mos(index-l:index+l))
plot(chi_array(index),mass,'o')
legend ('M02', 'M01', 'M0')
hold off
title('Solid & LOX/LC2')
ylabel('Mass (metric tons)')
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
%% Solid & LOX/RP1
close all;
clear;
clc;
%Givens
delta_v = 12.3; %km/s
m_pl = 26000; %kg
delta = 0.08; %Inert mass fraction for both stages
chi = 0.01:0.01:0.99; %array
Isp1 = 269; %s (for solid)
Isp2 = 311; %s (for LOX/LRP1)
% Equations 

[M01_array, M02_array, chi_array] = getMass(delta_v,m_pl,delta,chi,Isp1,Isp2);
M01_array=M01_array/1000;
M02_array=M02_array/1000;
Mos=M01_array+M02_array;
[mass, index] = findMinMass(Mos)
l=round(length(chi_array)/4);

figure (1)
plot(chi_array(index-l:index+l), M02_array(index-l:index+l))
hold on
grid on
plot(chi_array(index-l:index+l), M01_array(index-l:index+l))
plot(chi_array(index-l:index+l),Mos(index-l:index+l))
plot(chi_array(index),mass,'o')
legend ('M02', 'M01', 'M0')
hold off
title('Solid & LOX/RP1')
ylabel('Mass (metric tons)')
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
%% Solid & Solid
close all;
clear;
clc;
%Givens
delta_v = 12.3; %km/s
m_pl = 26000; %kg
delta = 0.08; %Inert mass fraction for both stages
chi = 0.01:0.01:0.99; %array
Isp1 = 269; %s (for solid)
Isp2 = 269; %s (for solid)
% Equations 

[M01_array, M02_array, chi_array] = getMass(delta_v,m_pl,delta,chi,Isp1,Isp2);
M01_array=M01_array/1000;
M02_array=M02_array/1000;
Mos=M01_array+M02_array;
[mass, index] = findMinMass(Mos)
l=round(length(chi_array)/4);

figure (1)
plot(chi_array(index-l:index+l), M02_array(index-l:index+l))
hold on
grid on
plot(chi_array(index-l:index+l), M01_array(index-l:index+l))
plot(chi_array(index-l:index+l),Mos(index-l:index+l))
plot(chi_array(index),mass,'o')
legend ('M02', 'M01', 'M0')
hold off
title('Solid & Solid')
ylabel('Mass (metric tons)')
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
%% Solid & Solid
close all;
clear;
clc;
%Givens
delta_v = 12.3; %km/s
m_pl = 26000; %kg
delta = 0.08; %Inert mass fraction for both stages
chi = 0.01:0.01:0.99; %array
Isp1 = 269; %s (for solid)
Isp2 = 285; %s (for storables)
% Equations 

[M01_array, M02_array, chi_array] = getMass(delta_v,m_pl,delta,chi,Isp1,Isp2);
M01_array=M01_array/1000;
M02_array=M02_array/1000;
Mos=M01_array+M02_array;
[mass, index] = findMinMass(Mos)
l=round(length(chi_array)/4);

figure (1)
plot(chi_array(index-l:index+l), M02_array(index-l:index+l))
hold on
grid on
plot(chi_array(index-l:index+l), M01_array(index-l:index+l))
plot(chi_array(index-l:index+l),Mos(index-l:index+l))
plot(chi_array(index),mass,'o')
legend ('M02', 'M01', 'M0')
hold off
title('Solid & Storables')
ylabel('Mass (metric tons)')
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