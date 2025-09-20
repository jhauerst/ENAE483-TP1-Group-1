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
title('Solid & LOX/LCH4')
ylabel('Mass (metric tons)')
xlabel('Chi')


[m_pr1, m_pr2] = propMass(delta,M01_array,M02_array, m_pl);

%finding cost of the minimum mass 
[m_in1,m_in2]=inertMass(delta, M01_array(index).*1000, M02_array(index).*1000);
minmasscost1=stageCost(m_in1);
minmasscost2=stageCost(m_in2);
LVcost_min=minmasscost2+minmasscost1

%finding minimum cost
[costm_in1,costm_in2]=inertMass(delta, M01_array.*1000, M02_array.*1000);
mass1cost=stageCost(costm_in1);
mass2cost=stageCost(costm_in2);
totalmasscost=mass1cost+mass2cost;
[mincost,cindex]=findMinCost(totalmasscost)

figure (2)
plot(chi_array(cindex-l:cindex+l), mass1cost(cindex-l:cindex+l))
hold on
grid on
plot(chi_array(cindex-l:cindex+l), mass2cost(cindex-l:cindex+l))
plot(chi_array(cindex-l:cindex+l),totalmasscost(cindex-l:cindex+l))
plot(chi_array(cindex),mincost,'o')
legend ('stage 2 cost', 'stage 1 cost', 'total cost')
hold off
title('Solid & LOX/LCH4')
ylabel('Cost (millions)')
xlabel('Chi')

mincostmass=Mos(cindex)
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
title('Solid & LOX/LH2')
ylabel('Mass (metric tons)')
xlabel('Chi')


[m_pr1, m_pr2] = propMass(delta,M01_array,M02_array, m_pl);

%finding cost of the minimum mass 
[m_in1,m_in2]=inertMass(delta, M01_array(index).*1000, M02_array(index).*1000);
minmasscost1=stageCost(m_in1);
minmasscost2=stageCost(m_in2);
LVcost_min=minmasscost2+minmasscost1

%finding minimum cost
[costm_in1,costm_in2]=inertMass(delta, M01_array.*1000, M02_array.*1000);
mass1cost=stageCost(costm_in1);
mass2cost=stageCost(costm_in2);
totalmasscost=mass1cost+mass2cost;
[mincost,cindex]=findMinCost(totalmasscost)

figure (2)
plot(chi_array(cindex-l:cindex+l), mass1cost(cindex-l:cindex+l))
hold on
grid on
plot(chi_array(cindex-l:cindex+l), mass2cost(cindex-l:cindex+l))
plot(chi_array(cindex-l:cindex+l),totalmasscost(cindex-l:cindex+l))
plot(chi_array(cindex),mincost,'o')
legend ('stage 2 cost', 'stage 1 cost', 'total cost')
hold off
title('Solid & LOX/LH2')
ylabel('Cost (millions)')
xlabel('Chi')

mincostmass=Mos(cindex)
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

%finding cost of the minimum mass 
[m_in1,m_in2]=inertMass(delta, M01_array(index).*1000, M02_array(index).*1000);
minmasscost1=stageCost(m_in1);
minmasscost2=stageCost(m_in2);
LVcost_min=minmasscost2+minmasscost1

%finding minimum cost
[costm_in1,costm_in2]=inertMass(delta, M01_array.*1000, M02_array.*1000);
mass1cost=stageCost(costm_in1);
mass2cost=stageCost(costm_in2);
totalmasscost=mass1cost+mass2cost;
[mincost,cindex]=findMinCost(totalmasscost)

figure (2)
plot(chi_array(cindex-l:cindex+l), mass1cost(cindex-l:cindex+l))
hold on
grid on
plot(chi_array(cindex-l:cindex+l), mass2cost(cindex-l:cindex+l))
plot(chi_array(cindex-l:cindex+l),totalmasscost(cindex-l:cindex+l))
plot(chi_array(cindex),mincost,'o')
legend ('stage 2 cost', 'stage 1 cost', 'total cost')
hold off
title('Solid & LOX/RP1')
ylabel('Cost (millions)')
xlabel('Chi')

mincostmass=Mos(cindex)
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

%finding cost of the minimum mass 
[m_in1,m_in2]=inertMass(delta, M01_array(index).*1000, M02_array(index).*1000);
minmasscost1=stageCost(m_in1);
minmasscost2=stageCost(m_in2);
LVcost_min=minmasscost2+minmasscost1

%finding minimum cost
[costm_in1,costm_in2]=inertMass(delta, M01_array.*1000, M02_array.*1000);
mass1cost=stageCost(costm_in1);
mass2cost=stageCost(costm_in2);
totalmasscost=mass1cost+mass2cost;
[mincost,cindex]=findMinCost(totalmasscost)

figure (2)
plot(chi_array(cindex-l:cindex+l), mass1cost(cindex-l:cindex+l))
hold on
grid on
plot(chi_array(cindex-l:cindex+l), mass2cost(cindex-l:cindex+l))
plot(chi_array(cindex-l:cindex+l),totalmasscost(cindex-l:cindex+l))
plot(chi_array(cindex),mincost,'o')
legend ('stage 2 cost', 'stage 1 cost', 'total cost')
hold off
title('Solid & Solid')
ylabel('Cost (millions)')
xlabel('Chi')

mincostmass=Mos(cindex)
%% Solid & Storables
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

%finding cost of the minimum mass 
[m_in1,m_in2]=inertMass(delta, M01_array(index).*1000, M02_array(index).*1000);
minmasscost1=stageCost(m_in1);
minmasscost2=stageCost(m_in2);
LVcost_min=minmasscost2+minmasscost1

%finding minimum cost
[costm_in1,costm_in2]=inertMass(delta, M01_array.*1000, M02_array.*1000);
mass1cost=stageCost(costm_in1);
mass2cost=stageCost(costm_in2);
totalmasscost=mass1cost+mass2cost;
[mincost,cindex]=findMinCost(totalmasscost)

figure (2)
plot(chi_array(cindex-l:cindex+l), mass1cost(cindex-l:cindex+l))
hold on
grid on
plot(chi_array(cindex-l:cindex+l), mass2cost(cindex-l:cindex+l))
plot(chi_array(cindex-l:cindex+l),totalmasscost(cindex-l:cindex+l))
plot(chi_array(cindex),mincost,'o')
legend ('stage 2 cost', 'stage 1 cost', 'total cost')
hold off
title('Solid & Storables')
ylabel('Cost (millions)')
xlabel('Chi')

mincostmass=Mos(cindex)