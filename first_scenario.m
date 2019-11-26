function [] = first_scenario()

global EV N periods home_vehicles Pt_available_EU Ct_available_EU home_vehicle_SOC_predictions_param_1st
for t = 1:periods
    
    if t == 1 %For the first second, initialize every EV SOC as it's isoc.
        for i = 1:N
            EV(i).soc(t) = EV(i).isoc;
        end
    end
    
    for i = 1:N
        func = equation_12_13_constraint(i,t); %Check whether the EV is in the parking lot or not based on its schedule.
        if func == 1 %if the vehicle is not at the charging station
            if t ~= 1
                EV(i).soc(t) = EV(i).soc(t - 1);
            else
                EV(i).soc(t) = EV(i).isoc;
            end
            if ismember(i,home_vehicles) && ((t >= EV(i).schedule(2) && t < EV(i).schedule(3)) || (t >= EV(i).schedule(4) && t < EV(i).schedule(5)))%if the vehicle is in transit
                EV(i).x(t) = 0;
                EV(i).y(t) = 0;
                if t ~= 1
                    EV(i).soc(t) = EV(i).soc(t-1) - 1;
                else
                    EV(i).soc(t) = EV(i).isoc - 1;
                end
                if t == EV(i).schedule(4) %when the vehicle leaves home, record the current state of charge
                    [index, a] = ismember(i,home_vehicles);
                    home_vehicle_SOC_predictions_param_1st(2,index) = EV(i).soc(t);
                end
            elseif ismember(i,home_vehicles) && (t >= EV(i).schedule(3) && t < EV(i).schedule(4)) && EV(i).soc(t - 1) > EV(i).mr %if the vehicle is at home discharging
                EV(i).y(t) = 1;
                EV(i).x(t) = 0;
                EV(i).soc(t) = EV(i).soc(t-1) - 1; %The EV is at the owner's home and is charging the home load.
                if t == EV(i).schedule(3) %when the EV reaches home, record the current state of charge
                    [index, a] = ismember(i,home_vehicles);
                    home_vehicle_SOC_predictions_param_1st(1,index) = EV(i).soc(t);
                end
            elseif ~ismember(i,home_vehicles)
                EV(i).x(t) = 0;
                EV(i).y(t) = 0;
            end

        else %if the vehicle is at the charging station
            
            EV(i).x(t) = 1;
            EV(i).y(t) = 0;
            
        end
            
            %Ensure all constraints on x and y states are met, else x and y are
            %the same as their values in the previous time period.
            if equation_6_constraint(t) == 0
                EV(i).x(t) = 0;
            end
            
            if equation_11_constraint(i,t) == 0
                if EV(i).soc(t) >= EV(i).u
                    EV(i).x(t) = 0;
                else
                    EV(i).y(t) = 0;
                end
            end
            
            %Update SOCs at this point.
            equation_7_update(i,t);
        
            %Ensure newly calculated SOCs meet constraints on them.
            if equation_9_constraint(i,t) == 0
                try
                    EV(i).soc(t) = EV(i).soc(t-1);
                catch
                    EV(i).soc(t) = EV(i).isoc;
                end
                EV(i).y(t) = 0;
            end
            
            if equation_10_constraint(i,t) == 0
                try
                    EV(i).soc(t) = EV(i).soc(t-1);
                catch
                    EV(i).soc(t) = EV(i).isoc;
                end
                EV(i).x(t) = 0;
            end
            %Calculate the current period mode and resulting switching result.
            equation_14_constraint(i,t);
            equation_15_16_switching(i,t);
        
        %Update currrent profit/cost
        EV(i).profit = EV(i).profit + EV(i).y(t)*Pt_available_EU(t) - EV(i).x(t)*Ct_available_EU(t);
    end
end

%Calculate the unfulfilled battery charge (z) for each EV after the 48 periods.
for i = 1:N
    EV(i).z = EV(i).u - EV(i).isoc - sum(EV(i).x) + sum(EV(i).y);
    if EV(i).z < 0
        EV(i).z = 0;
    end
end

%Using the recorded SOC values when the travelling EVs arrive at home,
%when they leave after discharging at home and the distance between their
%home and station

predict_SOCs_1st
end