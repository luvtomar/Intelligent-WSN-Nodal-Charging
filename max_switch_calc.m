global EV N 
%%Initialize the maximum number of switches for each EV as per the table
%%shown on page 41 of the pdf.
for i = 1:N
    if EV(i).age <= 3
        EV(i).nsw = 8;
    elseif EV(i).age <= 7
        EV(i).nsw = 7;
    else
        EV(i).nsw = 5;
    end
end