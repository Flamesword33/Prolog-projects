myLength([], 0).
myLength([_ | Rest], Num) :- myLength(Rest, LenRest),
    Num is LenRest + 1.

