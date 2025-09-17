%Get propellant mass
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