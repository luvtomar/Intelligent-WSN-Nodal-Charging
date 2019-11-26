function [] = equation_7_update(i,t)

global EV cpt_available_EU

    if t > 1
        EV(i).soc(t) = EV(i).soc(t-1) + EV(i).x(t) - EV(i).y(t);
        if EV(i).soc(t-1) < EV(i).soc(t)
            cpt_available_EU(t) = cpt_available_EU(t) - (EV(i).soc(t) - EV(i).soc(t-1));
        end
    end

end