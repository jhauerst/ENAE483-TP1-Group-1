%% Oxidizer/fuel Mass finder
function [oxidizer_mass, fuel_mass] = findFuelMass(Mpr0, ratio_array)
    tot_ratio = ratio_array(1) + ratio_array(2);
    oxz_ratio = ratio_array(1)/tot_ratio;
    ful_ratio = ratio_array(2)/tot_ratio;
    oxidizer_mass = oxz_ratio*Mpr0;
    fuel_mass = ful_ratio*Mpr0;
end


