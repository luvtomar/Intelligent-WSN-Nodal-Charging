function [result] = equation_11_constraint(i,t)

global EV

if (EV(i).x(t) + EV(i).y(t)) <= 1
    result = 1;
else
    result = 0;
end

end