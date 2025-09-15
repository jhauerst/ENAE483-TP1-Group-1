%% Section 1.1
close all;
clear;
clc;
%Givens
delta_v = 12.3; %m/s
m_pl = 26000; %kg
delta = 0.08; %Inert mass fraction for both stages
chi = 0.01:0.01:0.99; %array
Isp1 = 366; %s (for LOX/LH2)
Isp2 = 366; %s (for LOX/LH2)
% Equations 

[M01_array, M02_array, chi_array] = getmass(delta_v,m_pl,delta,chi,Isp1,Isp2);

figure (1)
plot(chi_array, M02_array)
hold on
grid on
plot(chi_array, M01_array)
plot(chi_array,M01_array+M02_array)
legend 
hold off

%Get propellant mass
[m_pr1, m_pr2] = propmass(delta,M01_array,M02_array, m_pl);
figure(2)
subplot(2,1,1)
plot(M01_array,m_pr1)
grid on
subplot(2,1,2)
plot(M02_array,m_pr2)
grid on


function [M01_array, M02_array, chi_array] = getmass(delta_v,m_pl,delta,chi,Isp1,Isp2)
    syms M02 M01
    M02_array = [];
    M01_array = [];
    chi_array = [];

    for k = 1:length(chi)
        g = 9.81/1000;
        eqn2 = -Isp2*g*log((m_pl+delta*M02) / M02) - (1-chi(k))*delta_v == 0;
        soln2 = vpasolve(eqn2,M02);
        if soln2 > 0
            try 
                M02_array(end+1) = double(soln2);
                chi_array(end+1) = [chi(k)];
            catch
            end
        end
    end

    for k = 1:length(chi_array)
        eqn1 = -Isp1*g*log((M02_array(k)+delta*M01) / (M02_array(k)+M01)) - chi_array(k)*delta_v == 0;
        soln1 = vpasolve(eqn1,M01);
        if soln1 > 0
            try 
                M01_array(end+1) = double(soln1);
            catch
            end
        end
    end
    if length(M02_array) > length(M01_array)
        chi_array = chi_array(1:length(M01_array));
        M02_array = M02_array(1:length(M01_array));
    elseif length(M01_array) > length(M02_array)
        chi_array = chi_array(1:length(M02_array));
        M01_array = M01_array(1:length(M02_array));
    end

end

function [m_pr1, m_pr2] = propmass(delta,M01,M02, m_pl)
    m_pr1 =[];
    m_pr2 = [];
    for k = 1:length(M01)
        m_in1 = delta*M01(k);
        m_pr1(k) = M01(k) - m_in1;
        m_in2 = delta*M02(k);
        m_pr2(k) = M02(k) - m_pl - m_in2;
    end
end


        