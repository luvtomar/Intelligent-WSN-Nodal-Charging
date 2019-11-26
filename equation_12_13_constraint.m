function [result] = equation_12_13_constraint(i,t)

global EV home_vehicles

if ~ismember(i,home_vehicles) %for vehicles not taking mid home trips
    if t > EV(i).schedule(2) || t < EV(i).schedule(1) %if the current time is smaller before the arrival time or after the departure time
        result = 1;
    else
        result = 0;
    end
else%for vehicles taking mid home trips
    if t < EV(i).schedule(1) || (t >= EV(i).schedule(2) && t < EV(i).schedule(5)) || t > EV(i).schedule(6)
        result = 1;
    else
        result = 0;
    end
end

end