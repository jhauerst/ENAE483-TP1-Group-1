function [m_in1, m_in2] = inertMass(delta, M01_array, M02_array)
% INERTMASS  Find the inert mass given the inert mass fraction and the stage masses.
% 
%   [m_in1, m_in2] = INERTMASS(delta, M01_array, M02_array) Finds the
%   inert mass of stage 1 (from M01_array) and the inert mass of stage 2
%   (from M02_array) using inert mass fraction delta.
%
%   See also GETMASS, PROPMASS, FINDMINMASS.
    m_in1 = delta.*M01_array;
    m_in2 = delta.*M02_array;
end