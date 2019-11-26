global EV N

%assign the max battery capacity (in EUs) for each EV
for i = 1:N
    if EV(i).type == 0
        EV(i).mc = 10;
    else
        EV(i).mc = 15;
    end
end