function [result] = equation_18_constraint(i)

global EV periods

sum = 0;

for t = 1:periods
    sum = sum + EV(i).sw(t);
end

if sum <= EV(i).nsw
    result = 1;
else
    result = 0;
end

end