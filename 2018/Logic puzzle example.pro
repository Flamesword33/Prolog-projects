students([cindy, adam, jack, katharina]).
amountEarned([2500, 3000, 3500, 4000]).
minors([sociology, english, philosophy, physics]).

solution([[cindy,_,_], [adam,_,_], [jack,_,_], [katharina,_,_]]).

%=====================
%Rule 1
rule1(Solution) :-
    member([_, SocAmount, sociology], Solution),
    member([jack, JackAmount, _], Solution),
    SocAmount < JackAmount.
%=====================
%Rule 2
rule2(Solution) :-
    member([jack, _, english], Solution).
rule2(Solution) :-
    member([jack, _, philosophy], Solution).
%=====================
%Rule 3
rule3(Solution) :-
    member([_, PhisicsAmount, physics], Solution),
    member([cindy, CindyAmount, _], Solution),
    PhisicsAmount is CindyAmount + 500.
%=====================
%Rule 4
rule4(Solution) :-
    member([adam, AdamAmount, _], Solution),
    member([cindy, CindyAmount, _], Solution),
    AdamAmount is CindyAmount - 1000.
%=====================
%Rule 5
rule5(Solution) :-
    member([katharina, KathAmount, _], Solution),
    member([_, EngAmount, english], Solution),
    KathAmount > EngAmount.


%=====================
%Solve it

% bind the number possibilites so several rules work
constrainEarnings([]).

constrainEarnings([[_, Amount, _] | Rest]) :-
    amountEarned(EarnedAmts),
    member(Amount, EarnedAmts),
    constrainEarnings(Rest).

noRepetitionMinors([[_,_,M1], [_,_,M2],  [_,_,M3], [_,_,M4]]) :-
    M1 \== M2, M1 \== M3, M1 \== M4,
    M2 \== M3, M2 \== M4,
    M3 \== M4.

solve(X) :-
    solution(X),
    rule2(X),
    rule1(X),
    rule5(X),
    rule3(X),
    rule4(X).
