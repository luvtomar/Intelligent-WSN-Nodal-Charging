function [result] = equation_9_constraint(i,t)

global EV

if EV(i).soc(t) >= EV(i).mr
    result = 1;
else
    result = 0;
end
end