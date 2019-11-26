global N 
global EV 
global list_of_total_switches_made_2nd 
global frequency_of_switches_2nd 
global total_x_2nd
global total_y_2nd
global list_of_total_z_2nd
global frequency_of_z_2nd
global EV_2nd
global periods

%calculate the total number of switches for each EV (for figure 15,26 later)
for i = 1:N
    EV(i).sum_switches = sum(EV(i).sw);
end

EV_2nd = EV;

%create a list of all possible total number of switches made and how many
%EVs made each of those total number of switches.
list_of_total_switches_made_2nd = [];
for i = 1:N
    if ~ismember(EV(i).sum_switches, list_of_total_switches_made_2nd)
        list_of_total_switches_made_2nd = [list_of_total_switches_made_2nd EV(i).sum_switches];
    end
end

for i = 1:length(list_of_total_switches_made_2nd)
    frequency_of_switches_2nd(i) = 0;
    for j = 1:N
        if EV(j).sum_switches == list_of_total_switches_made_2nd(i)
            frequency_of_switches_2nd(i) = frequency_of_switches_2nd(i) + 1;
        end
    end
end

%for figures 16,17,18,21,22,23,27,28
for t = 1:periods
    sum_x = 0;
    sum_y = 0;
    for j = 1:N
        sum_x = sum_x + EV(j).x(t);
        sum_y = sum_y + EV(j).y(t);
    end
    total_x_2nd(t) = sum_x;
    total_y_2nd(t) = sum_y;
end

%create a list of all possible total number of unfulfilled battery EUs made and how many
%EVs made each of those total numbers. (for figures 19, 20)
list_of_total_z_2nd = [];
for i = 1:N
    if ~ismember(EV(i).z(periods), list_of_total_z_2nd)
        list_of_total_z_2nd = [list_of_total_z_2nd EV(i).z(periods)];
    end
end

for i = 1:length(list_of_total_z_2nd)
    frequency_of_z_2nd(i) = 0;
    for j = 1:N
        if EV(j).z(periods) == list_of_total_z_2nd(i)
            frequency_of_z_2nd(i) = frequency_of_z_2nd(i) + 1;
        end
    end
end