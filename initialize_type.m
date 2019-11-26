global EV N

%%Randomize 264 PHEVs (represented by integer 0) and 236 BEVs (represent by
%%integer 1). Then initialize the associated maximum battery capacity, mci.

PHEV_max = 264;
BEV_max = 236;

count_PHEV = 1;
count_BEV = 1;

for i = 1:N
    if count_PHEV > PHEV_max
        EV(i).type = 1;
    elseif count_BEV > BEV_max
        EV(i).type = 0;
    else
        EV(i).type = randi(2) - 1;
        if EV(i).type == 0
            count_PHEV = count_PHEV + 1;
        else
            count_BEV = count_BEV + 1;
        end
    end 
end