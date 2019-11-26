function [result] = equation_10_constraint(i,t)

global EV

if EV(i).soc(t) <= EV(i).mc
    result = 1;
else
    result = 0;
end
end