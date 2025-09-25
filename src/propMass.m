function [m_pr1, m_pr2] = propMass(delta,M01,M02, m_pl)
% PROPMASS  Find the propellant masses from the total stage masses.
%
%   [m_pr1, m_pr2] = PROPMASS(delta, M01, M02, m_pl) Find propellant masses
%   for stage 1 and 2 (m_pr1 and m_pr2), from total stage masses for stage 1 and 2 (M01 and
%   M02), using inert mass fraction (delta) and payload mass (m_pl).
%
%   See also GETMASS, INERTMASS, FINDMINMASS.
    m_pr1 =[]; % establish array
    m_pr2 = [];
    for k = 1:length(M01) % for length of stage 1 total mass array
        m_in1 = delta*M01(k); % inert mass formula for stage 1
        m_pr1(k) = M01(k) - m_in1; % mass of propellant stage 1
        m_in2 = delta*M02(k); % inert mass formula for stage 2
        m_pr2(k) = M02(k) - m_pl - m_in2; % mass of propellant stage 2
    end
end