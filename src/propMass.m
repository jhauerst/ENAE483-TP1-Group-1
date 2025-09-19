%Get propellant mass
function [m_pr1, m_pr2] = propMass(delta,M01,M02, m_pl)
    m_pr1 =[]; % establish array
    m_pr2 = [];
    for k = 1:length(M01) % for length of stage 1 total mass array
        m_in1 = delta*M01(k); % inert mass formula for stage 1
        m_pr1(k) = M01(k) - m_in1; % mass of propellant stage 1
        m_in2 = delta*M02(k); % inert mass formula for stage 2
        m_pr2(k) = M02(k) - m_pl - m_in2; % mass of propellant stage 2
    end
end