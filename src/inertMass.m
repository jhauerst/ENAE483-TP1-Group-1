function [m_in1, m_in2] = inertMass(delta, M01_array, M02_array)
    m_in1 = delta.*M01_array;
    m_in2 = delta.*M02_array;
end