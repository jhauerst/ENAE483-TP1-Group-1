%% Section 1.1
%Givens
delta_v = 12300; %m/s
m_pl = 26000; %kg
delta = 0.08; %Inert mass fraction for both stages
chi = linspace(0.2,0.6,100); %array
Isp1 = 366; %s (for LOX/LH2)
Isp2 = 366; %s (for LOX/LH2)
% Equations 
[M01_array, M02_array] = getmass(delta_v,m_pl,delta,chi,Isp1,Isp2);

figure (1)
plot(chi, M02_array)
hold on
grid on
plot(chi, M01_array)
plot(chi,M01_array+M02_array)
legend 
hold off


function [M01_array, M02_array] = getmass(delta_v,m_pl,delta,chi,Isp1,Isp2)
    syms M02 M01
    M02_array = zeros(size(chi));
    M01_array = zeros(size(chi));

    for k = 1:length(chi)
        eqn2 = -Isp2*9.81*log((m_pl+delta*M02) / M02) - (1-chi(k))*delta_v == 0;
        soln2 = vpasolve(eqn2,M02);
        M02_array(k) = double(soln2);
    end

    for k = 1:length(chi)
        eqn1 = -Isp1*9.81*log((M02_array(k)+delta*M01) / (M02_array(k)+M01)) - chi(k)*delta_v == 0;
        soln1 = vpasolve(eqn1,M01)
        M01_array(k) = double(soln1);
    end

end
