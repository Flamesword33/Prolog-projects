/*
 * The Zebra Puzzle in Prolog
 *
 * by AUCSC 370
 * 29 November 2018
 *
 */

%Color, Nationality, Pet, Drink, Smoke
solution([[_, _, _, _, _],  %1st house
          [_, _, _, _, _],  %2nd house
          [_, _, _, _, _],  %3rd house
          [_, _, _, _, _],  %4th house
          [_, _, _, _, _]]).%5th house

%2 - The englishman lives in the red house
rule2(S) :-
    member([red, english, _, _, _], S).

%3 - The spaniard owns the dog
rule3(S) :-
    member([_, spanish, dog, _, _], S).

%4 - Coffee is drunk in the green house
rule4(S) :-
    member([green, _, _, coffee, _], S).

%5 - The Ukrainian drinks tea
rule5(S) :-
    member([_, ukrainian, _, tea, _], S).

%6 - The green house is immediately right of ivory house
rule6(S) :-
    rightOf([green, _, _, _, _], [ivory, _, _, _, _], S).

%rightOf(Element1, Element2, List)
%  is TRUE if Element1 is immediately to the right
%  of Element2 in the List
%
%

rightOf(Element1, Element2, [Element2, Element1 | _]).
rightOf(Element1, Element2, [Other | Rest]) :-
    Element2 \== Other,
    rightOf(Element1, Element2, Rest).

/*Playing with independence of predicates for rightOf
rightOf(Element1, Element2, [Other | Rest]) :-
    rightOf(Element1, Element2, Rest).
rightOf(Element1, Element2, [Element2, Element1 | _]).
*/

%7 - The Old Gold smoker owns snails
rule7(S) :-
    member([_, _, snail, _, oldGold], S).

%8 - Kools are smoked in the yellow house
rule8(S) :-
    member([yellow, _, _, _, kools], S).

%9 - Milk is drunk in the middle house
rule9([_, _, [_, _, _, milk, _], _, _]).

%10 - Norwegian lives in first house
rule10([[_, norwegian, _, _, _] | _]).

%11 - The man who smokes Chesterfields live in the house next
%to the man with the fox
rule11(S) :-
    nextTo([_, _, _, _, chesterfields], [_, _, fox, _, _], S).

% nextTo(Element1, Element2, List)
%   is TRUE if Element1 is immediately beside Element2
%   in List
nextTo(Element1, Element2, List) :-
    rightOf(Element1, Element2, List).
nextTo(Element1, Element2, List) :-
    rightOf(Element2, Element1, List).

% 12 - Kools are smoked in the house next to the house
% where the horse if kept
rule12(S) :-
    nextTo([_, _, _, _, kools], [_, _, horse, _, _], S).

%13 - The Lucky Strike smoker drinks orange juice
rule13(S) :-
    member([_, _, _, orangeJuice, luckyStrike], S).

%14 - The Japanese smokes Parliaments
rule14(S) :-
    member([_, japanese, _, _, parliaments], S).

%15 - The Norwegian lives next to the blue house
rule15(S) :-
    nextTo([blue, _, _, _, _], [_, norwegian, _, _, _], S).


solve :-
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
    member([_, _, zebra, _, _], S),
    member([_, _, _, water, _], S),

    write(S).

