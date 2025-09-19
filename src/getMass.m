function [M01_array, M02_array, chi_array] = getMass(delta_v,m_pl,delta,chi,Isp1,Isp2)
% GETMASS  Get total stage masses, M01 and M02.
%
%   [M01_array, M02_array, chi_array] = GETMASS(delta_v, m_pl, delta, chi, Isp1, Isp2)
%   Use the rocket equation to determine total stage masses given:
%   - delta_v: the required change in velocity
%   - m_pl: the required payload mass
%   - delta: the estimated inert mass fraction
%   - chi: the target delta V split between the first and second stage
%   - Isp1: the specific impulse of the first stage engines
%   - Isp2: the specific impulse of the second stage engines
%
%   See also PROPMASS, INERTMASS, FINDMINMASS.
    syms M02 M01
    %Initialize mass arrays
    M02_array = [];
    M01_array = [];
    chi_array = [];

    for k = 1:length(chi)
        g = 9.81/1000;%km/s^2
        %Rocket equation for stage two
        eqn2 = -Isp2*g*log((m_pl+delta*M02) / M02) - (1-chi(k))*delta_v == 0;
        soln2 = vpasolve(eqn2,M02); %Use vpa solver to find M02
        %The below loop excludes mass values that are negative and
        %populates the matrices for second stage
        if soln2 > 0 %
            try 
                M02_array(end+1) = double(soln2); %Store mass values
                chi_array(end+1) = [chi(k)]; %Store corresponding chi values
            catch
            end
        end
    end

    %Repeat same steps but for first stage
    for k = 1:length(chi_array) 
        g = 9.81/1000; %km/s^2
        %Rocket equation for stage one
        eqn1 = -Isp1*g*log((M02_array(k)+delta*M01) / (M02_array(k)+M01)) - chi_array(k)*delta_v == 0;
        soln1 = vpasolve(eqn1,M01);
        if soln1 > 0
            try 
                M01_array(end+1) = double(soln1); %Store mass values
            catch
            end
        end
    end
    %The below loop scales the chi array to the mass array with lower length 
    if length(M02_array) > length(M01_array)
        chi_array = chi_array(1:length(M01_array));%Scale chi to M01
        M02_array = M02_array(1:length(M01_array));%Scale M02 to M01
    elseif length(M01_array) > length(M02_array)
        chi_array = chi_array(1:length(M02_array));%Scale chi to M02
        M01_array = M01_array(1:length(M02_array));%Scale M01 to M02
    end

end