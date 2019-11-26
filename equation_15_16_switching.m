function [] = equation_15_16_switching(i,t)

global EV

if t > 1
    EV(i).F(t) = EV(i).md(t) - EV(i).md(t-1);
    if EV(i).F(t) == 0
        EV(i).sw(t) = 0;
    else
        EV(i).sw(t) = 1;
    end
end
end