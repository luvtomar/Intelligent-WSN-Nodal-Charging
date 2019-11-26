%% Randomly initiliaze the arrival and departure times as per the requirements and through a schedule
global EV N periods home_vehicles

% Every odd element of an EV's schedule represents arrival time, whereas
% every even element in a schedule is a departure time from the parking
% lot. 
for i = 1:N
    EV(i).schedule = zeros(1,1);
    count = 1;
    if ismember(i,home_vehicles)
        EV(i).schedule(count) = 12 + randi(10);
    else
        EV(i).schedule(count) = 12 + randi(25);
    end
    while EV(i).schedule(count) >= periods - (EV(i).u - EV(i).isoc) %Make sure the EV's schedule can accomodate the house load charging. 
        if ismember(i,home_vehicles)
            EV(i).schedule(count) = 12 + randi(10);
        else
            EV(i).schedule(count) = 12 + randi(25);
        end
    end
    
    if ismember(i,home_vehicles)
        EV(i).schedule = [EV(i).schedule 0 0 0 0 0]; %the EVs taking mid home trips have a longer schedule
        EV(i).schedule(count + 1) = 1 + EV(i).schedule(count) + randi(15); %time when vehicle leaves station
        EV(i).schedule(count + 2) = EV(i).schedule(count + 1) + EV(i).travel_time; %time when vehicle arrives at home
        EV(i).schedule(count + 3) = EV(i).schedule(count + 2) + EV(i).home_load; %time when vehicle finishes charging home load
        EV(i).schedule(count + 4) = EV(i).schedule(count + 3) + EV(i).travel_time; %time when vehicle returns to station
        try
            EV(i).schedule(count + 5) = EV(i).schedule(count + 4) + randi(periods - EV(i).schedule(count + 4)); %time when vehicle leaves station
        catch
            EV(i).schedule(count + 5) = periods;
        end
    else %The EVs only there to charge have only one arrival time and one departure time.
        EV(i).schedule = [EV(i).schedule EV(i).schedule(count) + EV(i).u - EV(i).isoc];
        while EV(i).schedule(count + 1) - EV(i).schedule(count) < EV(i).u - EV(i).isoc
            EV(i).schedule(count + 1) = EV(i).schedule(count) + EV(i).u - EV(i).isoc;
        end
    end
end