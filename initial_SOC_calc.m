global EV N
%%Randomize the initial state of charge of each EV between 1 EU and 14 EU
for i = 1:N
    EV(i).isoc = EV(i).mr + randi(4) - 1;
end