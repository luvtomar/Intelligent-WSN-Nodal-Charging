clear all
clc
close all
global EV 
global CS_first CS_second CS_third Ct_available_EU Pt_available_EU pc periods N home_vehicles max_loss planning_periods cpt_available_EU

global list_of_total_switches_made_1st 
global frequency_of_switches_1st 
global total_x_1st
global total_y_1st
global list_of_total_z_1st
global frequency_of_z_1st
global EV_1st

global list_of_total_switches_made_2nd 
global frequency_of_switches_2nd
global total_x_2nd
global total_y_2nd
global list_of_total_z_2nd
global frequency_of_z_2nd
global EV_2nd

global list_of_total_switches_made_3rd
global frequency_of_switches_3rd
global total_x_3rd
global total_y_3rd
global list_of_total_z_3rd
global frequency_of_z_3rd
global EV_3rd
global no_home_vehicles

global home_vehicle_SOC_predictions_1st
global home_vehicle_SOC_predictions_2nd
global home_vehicle_SOC_predictions_3rd
%% Initialize all the required variables and parameters

%Choose the number of vehicles you want taking mid-home trips to discharge
%at homes - default = 20

no_home_vehicles = 20;
main_initialization

max_loss = -100; %maximum cost in cents an EV owner is willing to pay for charging

%Customer satisfaction variables
CS_first = 0;
CS_second = 0;
CS_third = 0;

%% Simulation - 1st scenario
EV_initial = EV;

first_scenario

%Customer satisfaction calculation for first scenario
for t = 1:periods
    for i = 1:N
        CS_first = CS_first + EV(i).y(t)*Pt_available_EU(t) - EV(i).x(t)*Ct_available_EU(t);
    end
end

first_scenario_plot_parameters

%% Analysis of travelling EV's that took home trips - first scenario
fprintf('FOR THE FIRST SCENARIO,\n\n');
for j = 1:length(home_vehicles)
    fprintf('Electric vehicle %i had the following states of charge at the associated arrival/departure times:\n', home_vehicles(j));
    for i = 1:length(EV(home_vehicles(j)).schedule)
        if rem(i,2) ~= 0
            fprintf('Arrival time at period %i => SOC of %i percent of maximum battery level\n', EV(home_vehicles(j)).schedule(i), EV(home_vehicles(j)).soc(EV(home_vehicles(j)).schedule(i))*100/EV(home_vehicles(j)).mc);
        else
            fprintf('Departure time at period %i => SOC of %i percent of maximum battery level\n', EV(home_vehicles(j)).schedule(i), EV(home_vehicles(j)).soc(EV(home_vehicles(j)).schedule(i))*100/EV(home_vehicles(j)).mc);
        end
    end
    fprintf('\n');
    fprintf('Estimated SOC percentage at the end of the simulation = %i percent\n', home_vehicle_SOC_predictions_1st(i)*100/EV(home_vehicles(j)).mc);
    fprintf('Actual SOC percentage at the end of the simulation = %i percent\n', EV(home_vehicles(j)).soc(EV(home_vehicles(j)).schedule(6))*100/EV(home_vehicles(j)).mc);
    fprintf('\n');
end


%% Simulation - 2nd scenario
EV = EV_initial;

second_scenario

%Customer satisfaction calculation for second scenario.
for i = 1:N
    for t = 1:periods
        CS_second = CS_second + EV(i).y(t)*Pt_available_EU(t) - EV(i).x(t)*Ct_available_EU(t);
    end
    CS_second = CS_second - pc*EV(i).z;
end

second_scenario_plot_parameters

%% Analysis of travelling EV's that took home trips - second scenario
fprintf('FOR THE SECOND SCENARIO,\n\n');
for j = 1:length(home_vehicles)
    fprintf('Electric vehicle %i had the following states of charge at the associated arrival/departure times:\n', home_vehicles(j));
    for i = 1:length(EV(home_vehicles(j)).schedule)
        if rem(i,2) ~= 0
            fprintf('Arrival time at period %i => SOC of %i percent of maximum battery level\n',EV(home_vehicles(j)).schedule(i), EV(home_vehicles(j)).soc(EV(home_vehicles(j)).schedule(i))*100/EV(home_vehicles(j)).mc);
        else
            fprintf('Departure time at period %i => SOC of %i percent of maximum battery level\n',EV(home_vehicles(j)).schedule(i), EV(home_vehicles(j)).soc(EV(home_vehicles(j)).schedule(i))*100/EV(home_vehicles(j)).mc);
        end
    end
    fprintf('\n');
    fprintf('Estimated SOC percentage at the end of the simulation = %i percent\n', home_vehicle_SOC_predictions_2nd(i)*100/EV(home_vehicles(j)).mc);
    fprintf('Actual SOC percentage at the end of the simulation = %i percent\n', EV(home_vehicles(j)).soc(EV(home_vehicles(j)).schedule(6))*100/EV(home_vehicles(j)).mc);
    fprintf('\n');
end


%% Simulation - third scenario
EV = EV_initial;

third_scenario

%Customer satisfaction calculation for third scenario
for i = 1:N
    for t = 1:periods
        CS_third = CS_third + EV(i).y(t)*Pt_available_EU(t) - EV(i).x(t)*Ct_available_EU(t) - EV(i).sw(t)*pc;
    end
    CS_third = CS_third - pc*EV(i).z;
end

third_scenario_plot_parameters

%% Analysis of travelling EV's that took home trips - third scenario
fprintf('FOR THE THIRD SCENARIO,\n\n');
for j = 1:length(home_vehicles)
    fprintf('Electric vehicle %i had the following states of charge at the associated arrival/departure times:\n', home_vehicles(j));
    for i = 1:length(EV(home_vehicles(j)).schedule)
        if rem(i,2) ~= 0
            fprintf('Arrival time at period %i => SOC of %i percent of maximum battery level\n',EV(home_vehicles(j)).schedule(i), EV(home_vehicles(j)).soc(EV(home_vehicles(j)).schedule(i))*100/EV(home_vehicles(j)).mc);
        else
            fprintf('Departure time at period %i => SOC of %i percent of maximum battery level\n',EV(home_vehicles(j)).schedule(i), EV(home_vehicles(j)).soc(EV(home_vehicles(j)).schedule(i))*100/EV(home_vehicles(j)).mc);
        end
    end
    fprintf('\n');
    fprintf('Estimated SOC percentage at the end of the simulation = %i percent\n', home_vehicle_SOC_predictions_3rd(i)*100/EV(home_vehicles(j)).mc);
    fprintf('Actual SOC percentage at the end of the simulation = %i percent\n', EV(home_vehicles(j)).soc(EV(home_vehicles(j)).schedule(6))*100/EV(home_vehicles(j)).mc);
    fprintf('\n');
end

%% Figure 15/26

[list_of_total_switches_made_1st, switch_index_1st] = sort(list_of_total_switches_made_1st);
switch_freq_temp_1st = frequency_of_switches_1st;
for i = 1:length(switch_freq_temp_1st)
    frequency_of_switches_1st(i) = switch_freq_temp_1st(switch_index_1st(i));
    if ~ismember(list_of_total_switches_made_1st(i),list_of_total_switches_made_2nd)
        list_of_total_switches_made_2nd = [list_of_total_switches_made_2nd list_of_total_switches_made_1st(i)];
        frequency_of_switches_2nd = [frequency_of_switches_2nd 0];
    end
    if ~ismember(list_of_total_switches_made_1st(i),list_of_total_switches_made_3rd)
        list_of_total_switches_made_3rd = [list_of_total_switches_made_3rd list_of_total_switches_made_1st(i)];
        frequency_of_switches_3rd = [frequency_of_switches_3rd 0];
    end
end

[list_of_total_switches_made_2nd, switch_index_2nd] = sort(list_of_total_switches_made_2nd);
switch_freq_temp_2nd = frequency_of_switches_2nd;
for i = 1:length(switch_freq_temp_2nd)
    frequency_of_switches_2nd(i) = switch_freq_temp_2nd(switch_index_2nd(i));
end

[list_of_total_switches_made_3rd, switch_index_3rd] = sort(list_of_total_switches_made_3rd);
switch_freq_temp_3rd = frequency_of_switches_3rd;
for i = 1:length(switch_freq_temp_3rd)
    frequency_of_switches_3rd(i) = switch_freq_temp_3rd(switch_index_3rd(i));
end

plot_param = zeros(length(frequency_of_switches_1st),3);
for i = 1:length(frequency_of_switches_1st)
    for j = 1:3
        if j == 1
            plot_param(i,j) = frequency_of_switches_1st(i);
        elseif j == 2
            plot_param(i,j) = frequency_of_switches_2nd(i);
        else
            plot_param(i,j) = frequency_of_switches_3rd(i);
        end
    end
end

figure(1)
bar(list_of_total_switches_made_1st, plot_param)
title('Figure 15/26')
xlabel('Number of Switches')
ylabel('Frequency')
legend('Scenario 1','Scenario 2', 'Scenario 3')

%% Figure 16/22

figure(2)
plot(planning_periods, total_x_1st, planning_periods, total_x_2nd, 'r', planning_periods, total_x_3rd, 'g')
title('Figure 16/22')
xlabel('Time')
ylabel('Electricty Units')
legend('Scenario 1','Scenario 2', 'Scenario 3')

%% Figure 17/23

figure(3)
plot(planning_periods, total_y_1st, planning_periods, total_y_2nd, 'r', planning_periods, total_y_3rd, 'g')
title('Figure 17/23')
xlabel('Time')
ylabel('Electricty Units')
legend('Scenario 1','Scenario 2', 'Scenario 3')

%% Figure 18/27

figure(4)
yyaxis left
plot(planning_periods, total_x_3rd, planning_periods, total_y_3rd)
title('Figure 18/27')
xlabel('Time')
ylabel('Electricity Units')
yyaxis right
plot(planning_periods, Ct_available_EU)
ylabel('Price (cents)')
legend('Charging','Discharging','Price')

%% Figure 19/24

[list_of_total_z_1st, z_index_1st] = sort(list_of_total_z_1st);
z_freq_temp_1st = frequency_of_z_1st;
for i = 1:length(z_freq_temp_1st)
    frequency_of_z_1st(i) = z_freq_temp_1st(z_index_1st(i));
    if ~ismember(list_of_total_z_1st(i),list_of_total_z_2nd)
        list_of_total_z_2nd = [list_of_total_z_2nd list_of_total_z_1st(i)];
        frequency_of_z_2nd = [frequency_of_z_2nd 0];
    end
    if ~ismember(list_of_total_z_1st(i),list_of_total_z_3rd)
        list_of_total_z_3rd = [list_of_total_z_3rd list_of_total_z_1st(i)];
        frequency_of_z_3rd = [frequency_of_z_3rd 0];
    end
end

[list_of_total_z_2nd, z_index_2nd] = sort(list_of_total_z_2nd);
z_freq_temp_2nd = frequency_of_z_2nd;
for i = 1:length(z_freq_temp_2nd)
    frequency_of_z_2nd(i) = z_freq_temp_2nd(z_index_2nd(i));
end

[list_of_total_z_3rd, z_index_3rd] = sort(list_of_total_z_3rd);
z_freq_temp_3rd = frequency_of_z_3rd;
for i = 1:length(z_freq_temp_3rd)
    frequency_of_z_3rd(i) = z_freq_temp_3rd(z_index_3rd(i));
end

plot_param = zeros(length(frequency_of_z_1st),3);
for i = 1:length(frequency_of_z_1st)
    for j = 1:3
        if j == 1
            plot_param(i,j) = frequency_of_z_1st(i);
        elseif j == 2
            plot_param(i,j) = frequency_of_z_2nd(i);
        else
            plot_param(i,j) = frequency_of_z_3rd(i);
        end
    end
end

figure(5)
bar(list_of_total_z_1st, plot_param)
title('Figure 19/24')
xlabel('Z')
ylabel('Frequency')
legend('Scenario 1','Scenario 2', 'Scenario 3')

%% Figure 20/25

z_values_1st = [];
z_values_2nd = [];
z_values_3rd = [];
EVs = [];

for i = 1:N
    z_values_1st = [z_values_1st EV_1st(i).z];
    z_values_2nd = [z_values_2nd EV_2nd(i).z(periods)];
    z_values_3rd = [z_values_3rd EV_3rd(i).z(periods)];
    EVs = [EVs i];
end

figure(6)
plot(EVs, z_values_1st, EVs, z_values_2nd, 'r', EVs, z_values_3rd, 'g')
xlabel('EV Number')
ylabel('Electricity Units')
title('Figure 20/25')
legend('Z1','Z2','Z3')

%% Figure 21/28

figure(7)
plot(planning_periods, total_x_3rd, planning_periods, cpt_available_EU)
title('Figure 18/27')
xlabel('Time')
ylabel('Electricity Units')
legend('Charging','Capacity')

%% SOC vs distance plot of test EV taking home trip

%Assuming an initial SOC of 100% (i.e., of either 10 EU or 15 EU) can cover
%400 miles at full charge. First determine whether the test EV is PHEV or
%BEV

distance_per_EU = [];
distance_per_period = [];
total_periods = [];
home_vehicle_IDs = [];
for i = 1:N
    if ismember(i,home_vehicles)
        distance_per_EU = [distance_per_EU 400/EV(i).mc]; %Distance covered per EU depending on the type
        distance_per_period = distance_per_EU; %Assume 1 EU is spent in one period of travelling
        total_periods = [total_periods EV(i).travel_time];
        home_vehicle_IDs = [home_vehicle_IDs i];
    end
end

%EV energy vs distance plot 
random_num = randi(length(total_periods));
total_periods_vector = zeros(1,total_periods(random_num));
count = 0;
for i = 1:total_periods(random_num)
    count = count + 1;
    total_periods_vector(i) = count*distance_per_period(random_num);
end

%Create a uniformly distributed distance vector
total_periods_vector = linspace(total_periods_vector(1),total_periods_vector(length(total_periods_vector)),total_periods(random_num)+1);

start_time = EV_1st(home_vehicle_IDs(random_num)).schedule(2);
end_time = EV_1st(home_vehicle_IDs(random_num)).schedule(3);

figure(8)
plot(total_periods_vector, EV_1st(home_vehicle_IDs(random_num)).soc(start_time:end_time).*(100.*(EV_1st(home_vehicle_IDs(random_num)).mc).^(-1)),total_periods_vector, EV_2nd(home_vehicle_IDs(random_num)).soc(start_time:end_time).*(100.*(EV_2nd(home_vehicle_IDs(random_num)).mc).^(-1)),total_periods_vector, EV_3rd(home_vehicle_IDs(random_num)).soc(start_time:end_time).*(100.*(EV_3rd(home_vehicle_IDs(random_num)).mc).^(-1)))
title('Energy vs. Distance plot for randomly chosen vehicle to recharge home')
xlabel('Distance in miles')
ylabel('State of Charge of EV in Percentage of Max Capacity')
legend('1st Scenario','2nd Scenario', '3rd Scenario')

figure(9)
plot(total_periods_vector, EV_1st(home_vehicle_IDs(random_num)).soc(start_time:end_time).*(100.*(EV_1st(home_vehicle_IDs(random_num)).mc).^(-1)),total_periods_vector, EV_2nd(home_vehicle_IDs(random_num)).soc(start_time:end_time).*(100.*(EV_2nd(home_vehicle_IDs(random_num)).mc).^(-1)))
title('Energy vs. Distance plot for randomly chosen vehicle to recharge home')
xlabel('Distance in miles')
ylabel('State of Charge of EV in Percentage of Max Capacity')
legend('1st Scenario','2nd Scenario')

figure(10)
plot(total_periods_vector, EV_2nd(home_vehicle_IDs(random_num)).soc(start_time:end_time).*(100.*(EV_2nd(home_vehicle_IDs(random_num)).mc).^(-1)),total_periods_vector, EV_3rd(home_vehicle_IDs(random_num)).soc(start_time:end_time).*(100.*(EV_3rd(home_vehicle_IDs(random_num)).mc).^(-1)))
title('Energy vs. Distance plot for randomly chosen vehicle to recharge home')
xlabel('Distance in miles')
ylabel('State of Charge of EV in Percentage of Max Capacity')
legend('2nd Scenario', '3rd Scenario')

figure(11)
plot(total_periods_vector, EV_1st(home_vehicle_IDs(random_num)).soc(start_time:end_time).*(100.*(EV_1st(home_vehicle_IDs(random_num)).mc).^(-1)),total_periods_vector, EV_3rd(home_vehicle_IDs(random_num)).soc(start_time:end_time).*(100.*(EV_3rd(home_vehicle_IDs(random_num)).mc).^(-1)))
title('Energy vs. Distance Plot for Randomly Chosen Vehicle to Recharge Home')
xlabel('Distance in miles')
ylabel('State of Charge of EV in Percentage of Max Capacity')
legend('1st Scenario', '3rd Scenario')

%% SOC vs time plot of test EV taking home trip

figure(12)
plot(planning_periods, EV_1st(home_vehicle_IDs(random_num)).soc.*(100.*(EV_1st(home_vehicle_IDs(random_num)).mc).^(-1)), planning_periods, EV_2nd(home_vehicle_IDs(random_num)).soc.*(100.*(EV_2nd(home_vehicle_IDs(random_num)).mc).^(-1)), planning_periods, EV_3rd(home_vehicle_IDs(random_num)).soc.*(100.*(EV_3rd(home_vehicle_IDs(random_num)).mc).^(-1)))
title('Energy vs Time Plot for Randomly Chosen Vehicle to Recharge Home')
xlabel('Time in periods')
ylabel('State of Charge of EV in Percentage of Max Capacity')
legend('1st Scenario', '2nd Scenario', '3rd Scenario')

figure(13)
plot(planning_periods, EV_2nd(home_vehicle_IDs(random_num)).soc.*(100.*(EV_2nd(home_vehicle_IDs(random_num)).mc).^(-1)), planning_periods, EV_3rd(home_vehicle_IDs(random_num)).soc.*(100.*(EV_3rd(home_vehicle_IDs(random_num)).mc).^(-1)))
title('Energy vs Time Plot for Randomly Chosen Vehicle to Recharge Home')
xlabel('Time in periods')
ylabel('State of Charge of EV in Percentage of Max Capacity')
legend('2nd Scenario', '3rd Scenario')

figure(14)
plot(planning_periods, EV_1st(home_vehicle_IDs(random_num)).soc.*(100.*(EV_1st(home_vehicle_IDs(random_num)).mc).^(-1)), planning_periods, EV_3rd(home_vehicle_IDs(random_num)).soc.*(100.*(EV_3rd(home_vehicle_IDs(random_num)).mc).^(-1)))
title('Energy vs Time Plot for Randomly Chosen Vehicle to Recharge Home')
xlabel('Time in periods')
ylabel('State of Charge of EV in Percentage of Max Capacity')
legend('1st Scenario', '3rd Scenario')

figure(15)
plot(planning_periods, EV_1st(home_vehicle_IDs(random_num)).soc.*(100.*(EV_1st(home_vehicle_IDs(random_num)).mc).^(-1)), planning_periods, EV_2nd(home_vehicle_IDs(random_num)).soc.*(100.*(EV_2nd(home_vehicle_IDs(random_num)).mc).^(-1)))
title('Energy vs Time Plot for Randomly Chosen Vehicle to Recharge Home')
xlabel('Time in periods')
ylabel('State of Charge of EV in Percentage of Max Capacity')
legend('1st Scenario', '2nd Scenario')