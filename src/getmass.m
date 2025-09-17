%Get initial masses of M01 & M02
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