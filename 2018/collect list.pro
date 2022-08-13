% pack(List1, List2) is true if List2
% contains a list of lists, where each
% elsement of List2 is a list of all the
% characters that are the same
%
% ?- pack([a,a,a,a,b,c,c,d,d,d,e], X).
% X = [[a,a,a,a],[b],[c,c],[d,d,d],[e]]
%
pack([], []).
pack([First | Rest], [PackedFirst | PackedRest]) :-
    getAllFirst(First, Rest, PackedFirst, RestExceptFirstMatches),
    pack(RestExceptFirstMatches, PackedRest).

% getAllFirst(Elemement, List, PackedElement, RestOfList)
% Takes all copies of Element from List, makes a list of
% these to become PockedElement. Leaves remainder of
% list in RestOfList
%

% base case 1: empty list
getAllFirst(Element, [], [Element], []).

% base case 2: if next element is same as element
getAllFirst(Element, [Element | Rest], [Element | MoreElements], LeftOverList) :-
    getAllFirst(Element, Rest, MoreElements, LeftOverList)
    .

% base case 3: if next element is different
getAllFirst(Element1, [Element2 | Rest], [Element1], [Element2 | Rest]) :-
    Element1 \= Element2.
