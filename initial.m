clear all
clc
close all
N = 500; %number of Electric Vehicles
planning_periods = [];
period_length = 0.5; %period length in hours
periods = 24/period_length; %number of periods
for i = 1:periods
    planning_periods = [planning_periods i];
end

%Arrival and departure time initializations
ati = [];
dti = [];

for i = 1:N
    ati = [ati 0];
    dti = [dti 0];
end

%Available vehicles
AV = 0;
AVt = [];

for i = 1:periods
    if i >= 13 && i <= 37 %13th period represents 6 AM and 37th period represents 6 PM
        if i >= 25 %Assuming all EV owner want to park till at least 12 pm (25th period)
            
            number_new_EV = 18 + randi(2);
            count = 1;
            for j = 1:number_new_EV
                while ati(count) ~= 0
                    count = count + 1;
                end
                ati(count) = i;
                count = count + 1;
                if count == 489
                    adsf = 2;
                end
            end
            
            number_leaving_EV = 12 + randi(2);
            count = 1;
            for j = 1:number_new_EV
                try
                while dti(count) ~= 0
                    count = count + 1;
                end
                dti(count) = i;
                count = count + 1;
                catch
                    break;
                end
            end
            
            AV = AV + number_new_EV - number_leaving_EV; %Assume 20 to 22 cars enter and 7 to  cars leave the parking lot at the start of every period
        
        else
            
            number_new_EV = 18 + randi(2);
            count = 1;
            for j = 1:number_new_EV
                while ati(count) ~= 0
                    count = count + 1;
                end
                ati(count) = i;
                count = count + 1;
            end
            AV = AV + number_new_EV;
        
        end
        
    elseif i > 37
       
        number_leaving_EV = 18 + randi(2);
        count = 1;
            for j = 1:number_new_EV
                while dti(count) ~= 0
                    count = count + 1;
                end
                dti(count) = i;
                count = count + 1;
            end
        AV = AV - number_leaving_EV;%Assume 34 to 36 cars leave the parking lot at the end of every period
        if AV < 0
            AV = 0;
        end
        
    end
    
    AVt = [AVt AV];
end

for i = 1:length(ati)
    if ati(i) == 0
        ati(i) = 37; %remaining cars to arrive in latest period of arrivael (37)
    end
    if dti(i) == 0
        dti(i) = 48;%remaining cars to depart in last period
    end
end
plot(planning_periods,AVt)

%Electricity unit value
EU = 1.65e3;