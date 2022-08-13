% giveCoins(int, int, int, int, int, int)
%
% is Ture if the monetary value of coins is total
%
giveCoins(Twoonies, Loonies, Quarters, Dimes, Nickels, Total):-
    member(Twoonies, [0,1,2,3,4,5]),
    member(Loonies, [0,1]),
    member(Quarters, [0,1,2,3]),
    member(Dimes, [0,1,2]),
    member(Nickels, [0,1]),
    Total is Twoonies * 200 + Loonies * 100 + Quarters * 25 + Dimes * 10 + Nickels * 5.



