global EV N

%%Randomize all EVs' minimum desired electricity units retained, mri, with
%%either 1 EU, 2 EU or 3 EU, and as per the research paper requirements.

max_1_unit = 203;
max_2_units = 223;
max_3_units = 74;

count_1_unit = 1;
count_2_units = 1;
count_3_units = 1;

for i = 1:N
    if count_1_unit > max_1_unit%%with 203 EV's initialized with 1 EU, only initialize 2 EU or 3 EU to the rest
        EV(i).mr = randi(2) + 1;
        if EV(i).mr == 2
            count_2_units = count_2_units + 1;
        else
            count_3_units = count_3_units + 1;
        end
    elseif count_2_units > max_2_units%%with 223 EV's initialized with 2 EU, only initialize 1 EU or 3 EU to the rest
        number = randi(2);
        if number == 1
            EV(i).mr = 1;
            count_1_unit = count_1_unit + 1;
        else
            EV(i).mr = 3;
            count_3_units = count_3_units + 1;
        end
    elseif count_3_units > max_3_units %%with 74 EV's initialized with 3 EU, only initialize 2 EU or 1 EU to the rest
        EV(i).mr = randi(2);
        if EV(i).mr == 1
            count_1_unit = count_1_unit + 1;
        else
            count_2_units = count_2_units + 1;
        end
    elseif count_1_unit > max_1_unit && count_2_units > max_2_units
        EV(i).mr = 3;
        count_3_units = count_3_units + 1;
    elseif count_1_unit > max_1_unit && count_3_units > max_3_units
        EV(i).mr = 2;
        count_2_units = count_2_units + 1;
    elseif count_3_units > max_3_units && count_2_units > max_2_units
        EV(i).mr = 1;
        count_1_unit = count_1_unit + 1;
    else
        EV(i).mr = randi(3);
        if EV(i).mr == 1
            count_1_unit = count_1_unit + 1;
        elseif EV(i).mr == 2
            count_2_units = count_2_units + 1;
        else
            count_3_units = count_3_units + 1;
        end
    end 
end