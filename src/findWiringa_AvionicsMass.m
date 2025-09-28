%% Find wiring and avionics masses
function [wirMass,AvcMass] = findWiringa_AvionicsMass(M0,l)
    AvcMass = 10*(M0^0.361);
    wirMass = 1.058*sqrt(M0)*(l^0.25);
end
