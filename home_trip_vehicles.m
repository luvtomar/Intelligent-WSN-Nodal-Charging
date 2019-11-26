%Calculate random arrival and departure schedules for 20 vehicles out of
%the 500

global N home_vehicles home_vehicle_SOC_predictions_1st home_vehicle_SOC_predictions_param_1st no_home_vehicles
global home_vehicle_SOC_predictions_2nd home_vehicle_SOC_predictions_param_2nd
global home_vehicle_SOC_predictions_3rd home_vehicle_SOC_predictions_param_3rd
home_vehicles = []; %vector containing a list of vehicles taking mid home trips in the simulation

for i = 1:N
    new_EV = randi(N);
    while ismember(new_EV,home_vehicles)
        new_EV = randi(N);
    end
    home_vehicles = [home_vehicles new_EV];
    if length(home_vehicles) >= no_home_vehicles %This defines the number of vehicles the program user wants for home trips
        home_vehicle_SOC_predictions_1st = zeros(1, no_home_vehicles); %predicted final SOC values after discharging at home
        home_vehicle_SOC_predictions_param_1st = zeros(3, no_home_vehicles); %parameters used to compute predicted SOCs - arrival time at home, departure time from home, distance from home to station
        home_vehicle_SOC_predictions_2nd = zeros(1, no_home_vehicles); %predicted final SOC values after discharging at home
        home_vehicle_SOC_predictions_param_2nd = zeros(3, no_home_vehicles); %parameters used to compute predicted
        home_vehicle_SOC_predictions_3rd = zeros(1, no_home_vehicles); %predicted final SOC values after discharging at home
        home_vehicle_SOC_predictions_param_3rd = zeros(3, no_home_vehicles); %parameters used to compute predicted
        break;
    end
end