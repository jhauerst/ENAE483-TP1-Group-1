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
    g = 9.81/1000;%km/s^2

    for k = 1:length(chi)
        %Rocket equation for stage two
        eqn2 = -Isp2*g*log((m_pl+delta*M02) / M02) - (1-chi(k))*delta_v == 0;
        eqn1 = -Isp1*g*log((M02+delta*(M01+M02)) / (M02+M01)) - chi(k)*delta_v == 0;
        soln = vpasolve([eqn1, eqn2],[M01, M02]); %Use vpa solver to find M02

        %The below loop excludes mass values that are negative and
        %populates the matrices for both stages
        if (soln.M02 > 0 && soln.M01 > 0)%
            try 
                M02_array(end+1) = double(soln.M02); %Store mass values
                M01_array(end+1) = double(soln.M01); %Store mass values
                chi_array(end+1) = [chi(k)]; %Store corresponding chi values
            catch
            end
        end
    end

end