%Randomly initialize the travel time and electric house load for each EV
%owner
global N EV

for i = 1:N
    EV(i).travel_time = randi(4); %Travel time in terms of periods
    EV(i).home_load = randi(3); %House load in terms of EUs
end