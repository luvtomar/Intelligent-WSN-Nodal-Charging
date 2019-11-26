global EV N
%%Randomize the battery age of each EV between 1 year and 10 years
for i = 1:N
    EV(i).age = randi(10);
end