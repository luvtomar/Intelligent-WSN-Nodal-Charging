function [result] = equation_6_constraint(t)
global EV cpt_available_EU N

sum = 0;

for i = 1:N
    sum = sum + EV(i).x(t);
end

if sum > cpt_available_EU(t)
    result = 0;
else
    result = 1;
end

end