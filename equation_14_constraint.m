function [] = equation_14_constraint(i,t)

global EV

if t > 1
    EV(i).md(t) = EV(i).x(t) - EV(i).y(t);
else
    EV(i).md(t) = 0;
end
end