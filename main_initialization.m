global EV 
global N 
global planning_periods 
global period_length 
global periods
global pc

N = 500; %number of Electric Vehicles
planning_periods = []; %Vector of the 48 periods of the simulation
period_length = 0.5; %period length in hours
periods = 24/period_length; %number of periods
for i = 1:periods
    planning_periods = [planning_periods i];
end

%Randomly choose 10 EV's out of 500 that go home in between the simulation
%to charge their homes and then return. 
home_trip_vehicles

%Randomly initialize travel time to owners' homes and their loads.
initialize_travel_load

%Initialize the type of vehicle (BEV or PHEV).
initialize_type

%Initialize the maximum battery capacity as per the research paper.
max_battery_calc

%Initialize the minimum required battery level as per the research paper.
min_retain_calc

%Randomly assign the initial state of charge (isoc) of each EV as per the
%requirements.
initial_SOC_calc

%Randomly assign the desried state of charge (u) of each EV as per the
%requirements.
desired_SOC_calc

%Randomly assign the arrival and departure times of the EVs as per the
%owner requirements given earlier.
arrival_departure_time_calc

%Randomly assign the battery ages of the EVs.
randomize_age

%Randomly assign the maximum number of switches for each EV as per the
%research paper.
max_switch_calc

%Initialize the energy cost capacity for the parking lot as per the
%research paper.
initial_cost_capacity
pc = 19; %cost in cents of unfulfilled EV battery charge.

%Initialize the EV variables - x, y, md, z, soc, sw and current profit.

for i = 1:N
    EV(i).x = zeros(1,periods);
    EV(i).y = zeros(1,periods);
    EV(i).md = zeros(1,periods);
    EV(i).z = zeros(1,periods);
    EV(i).soc = zeros(1,periods);
    EV(i).sw = zeros(1,periods);
    EV(i).profit = 0;
end