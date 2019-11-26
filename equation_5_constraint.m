function [result] = equation_5_constraint(i)
global EV periods

sum_x = 0;
sum_y = 0;

for t = 1:periods
    sum_x = sum_x + EV(i).x(t);
    sum_y = sum_y + EV(i).y(t);
end

if sum_x - sum_y + EV(i).z == EV(i).u - EV(i).isoc
    result = 1;
else
    result = 0;
end

end