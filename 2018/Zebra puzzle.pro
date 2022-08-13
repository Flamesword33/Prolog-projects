/*
 * The Zebra puzzle
 *
 * by AUCSC 370
 * 29, Novemeber 2018
 *
 */
% Solution:
% colour, nationality, pet, drinks, smokes
solution([[_,_,_,_,_], %1st house
          [_,_,_,_,_], %2nd
          [_,_,_,_,_], %3rd
          [_,_,_,_,_], %4th
          [_,_,_,_,_]]). %5th

% Rule 1: 5 houses

% Rule 2: Englishman lives in red house
rule2(S) :-
    member([red, english, _,_,_], S).
% Rule 3: Spaniard owns the dog
rule3(S) :-
    member([_,spanish, dog,_,_], S).
% Rule 4: Coffee is drunk in green house
rule4(S) :-
    member([green,_,_,coffee,_], S).
% Rule 5: Ukrainian drinks tea
rule5(S) :-
    member([_,ukrainian,_,tea,_], S).
% Rule 6: The green house is immediately right of the ivory house
rule6(S) :-
    rightOf([green,_,_,_,_], [ivory,_,_,_,_], S).
% Rule 7: The old Gold smoker owns snails
rule7(S) :-
    member([_,_,snail,_,oldGold], S).
% Rule 8: Kools are smoked in yellow house
rule8(S) :-
    member([yellow,_,_,_,kools], S).
% Rule 9: Milk is drunk in the middle house
rule9([_,_,[_,_,_,milk,_],_,_]).
% Rule 10: Norwegian lives in first house
rule10([[_,norwegian,_,_,_]| _]).
% Rule 11: Chesterfield smokes, house next to man with fox
rule11(S) :-
    nextTo([_,_,_,_,chesterfields], [_,_,fox,_,_], S).
% Rule 12: kools smoked next to house with horse
rule12(S) :-
    nextTo([_,_,_,_,kools], [_,_,horse,_,_], S).
% Rule 13: Lucky Strike smokes, drink orange juice
rule13(S) :-
    member([_,_,_, orangeJuice, luckyStrikes], S).
% Rule 14: Japanese smokes Parliments
rule14(S) :-
    member([_,japanese,_,_,parliments], S).
% Rule 15: Norwegian lives next to blue house
rule15(S) :-
    nextTo([_,norwegian,_,_,_], [blue |_], S).


% rightOf
rightOf(Element1, Element2, [Element2, Element1 | _]).

rightOf(E1,E2, [Other | Rest]) :-
    E2 \== Other,
    rightOf(E1, E2, Rest).

% nextTo
nextTo(E1,E2, List) :-
    rightOf(E1, E2, List).
nextTo(E1, E2, List):-
    rightOf(E2, E1, List).

solve(S) :-
    solution(S),
    rule2(S),
    rule3(S),
    rule4(S),
    rule5(S),
    rule6(S),
    rule7(S),
    rule8(S),
    rule9(S),
    rule10(S),
    rule11(S),
    rule12(S),
    rule13(S),
    rule14(S),
    rule15(S),
    %Tell prolog that water and zebra exist
    member([_,_,zebra,_,_], S),
    member([_,_,_,water,_], S).












