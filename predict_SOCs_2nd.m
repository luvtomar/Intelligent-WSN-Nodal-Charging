%Using the recorded SOC values when the travelling EVs arrive at home,
%when they leave after discharging at home and the distance between their
%home and station, estimate the SOCs of the travelling vehicles at the end
%of the 2nd scenario

global home_vehicles home_vehicle_SOC_predictions_param_2nd home_vehicle_SOC_predictions_2nd EV
for i = 1:length(home_vehicles)
    home_vehicle_SOC_predictions_param_2nd(3,i) = EV(home_vehicles(i)).schedule(5) - EV(home_vehicles(i)).schedule(4); %the third parameter is the distance between home and station
    %The predicted SOC value is equal to the amount of discharge at home +
    %the charge lost during travel back to station after discharging
    home_vehicle_SOC_predictions_2nd(i) = 2*home_vehicle_SOC_predictions_param_2nd(1,i) - home_vehicle_SOC_predictions_param_2nd(2,i) + home_vehicle_SOC_predictions_param_2nd(3,i);
    if home_vehicle_SOC_predictions_2nd(i) > EV(home_vehicles(i)).mc
        home_vehicle_SOC_predictions_2nd(i) = EV(home_vehicles(i)).mc;
    end
end