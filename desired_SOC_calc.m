global EV N
%%Randomize the desired state of charge of each EV between 1 EU and 14 EU
for i = 1:N
    EV(i).u = EV(i).mc - randi(4) + 1;
end