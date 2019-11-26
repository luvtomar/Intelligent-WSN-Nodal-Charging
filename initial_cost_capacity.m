global Ct_available_EU Pt_available_EU cpt_available_EU Ct_NonEV Pt_NonEV cpt_NonEV

%%Initialize the following variables with the values determined in the
%%research paper - Ct, the price of every electricity unit during charging
%%period t, Pt, the price of each electricity unite during discharge period
%%t, and cpt, the electricity capacity available at the smart parking lot
%%to be used for charging EVs. (Figures 13 and 14)

Ct_available_EU = [10 10 9 9 8.5 8.5 8 8 7.75 7.75 7.75 7.75 8 8 9 9 11 11 11 12.5 12.5 14 14 14.75 14.75 15.5 15.5 16 16 16.5 16.5 18 18 19 19 17.5 17.5 18 18 15.25 15.25 13 13 13 13 13 12.5 12.5]; %Price in cents

Pt_available_EU = Ct_available_EU;

cpt_available_EU = [
    360
    360
    405
    405
    425
    425
    430
    430
    450
    450
    450
    450
    450
    430
    430
    390
    390
    320
    320
    260
    260
    170
    170
    110
    110
    190
    190
    140
    140
    90
    90
    130
    130
    80
    80
    35
    35
    55
    55
    175
    175
    230
    230
    230
    225
    225
    275
    275]';

Ct_NonEV = [
    10
    10
    8.5
    8.5
    8
    8
    7.5
    7.5
    7
    7
    7
    7
    7
    7.5
    7.5
    8.25
    8.25
    10.5
    10.5
    12.5
    12.5
    14.5
    14.5
    15
    15
    15.25
    15.25
    15.5
    15.5
    15.75
    15.75
    18.5
    18.5
    19
    19
    17.5
    17.5
    18
    18
    15.5
    15.5
    13.5
    13.5
    13.5
    13.5
    13.5
    12.5
    12.5]';

Pt_NonEV = Ct_NonEV;

cpt_NonEV = [
    2800
    2800
    2300
    2300
    2050
    2050
    1950
    1950
    1750
    1750
    1750
    1750
    1950
    1950
    2500
    2500
    3150
    3150
    3750
    3750
    4750
    4750
    5200
    5200
    4500
    4500
    5000
    5000
    5400
    5400
    5200
    5200
    5500
    5500
    6000
    6000
    5800
    5800
    4700
    4700
    4000
    4000
    4000
    4000
    4100
    4100
    3700
    3700
    ]';