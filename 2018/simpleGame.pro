%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The Alphabet Game
%
% This simple game is written to illustrate how to control the flow
% of events in a game in Prolog, including early termination (if the user
% wants to quit), repeating a turn in the case of an error, and
% terminating due to a win.
%
% J. Mohr
% 2003.12.1
%
% Adaptions by R. Heise
% 2018.11.20
% Mainly bug fix on member of a string in predicate __, cleaned up
% underscores, added documention and removed use of "once" predicate.
% Also made initial letter start at random, not at 'd'.
% Also removed a bunch of random cuts.  Will use this file to show
% students how to place a cut to force a hard stop on entry of 'z'.
%
% NOTE:  user MUST enter only a single letter each time
%
% Predicates:
% play
%    Start the game
% play(N)
%    play N rounds
% prevLetter(N)
%    Tracks the previous letter
% init  (Mohr's was initialize, but that is predefined in SWI-Prolog)
%    Initializes the game
% printInstructions
%    Prints game instructions
% promptGetInput
%    Get one character as input (and clears one newline)
% move
%    Evaluates the entry, and determines what to do next
% alphaL
%    Determines if the entry is a lower case letter
% isNext
%    Determines if the entry is the next letter
% nextMove
%    Either ends the game, or calls for next "round"
% replay
%    Handles incorrect input message
%

:- dynamic(prevLetter/1).

lowerCaseAlpha([97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108,
		109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
		121, 122]). %'a', 'b', ... 'z'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize and start game play.
play :-
	init,
	printInstructions,
	play(1).

play(N) :-
	promptGetInput(N, Char),
	move(N, Char).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clean up after a previous game.
% Set starting letter for a new game.
init :-
	retractall(prevLetter(_)),
	RandNum is random(23), %Pick between 'a' and 'w'
	lowerCaseAlpha(LowerCaseLetters),
	nth0(RandNum, LowerCaseLetters, StartLetter),
	assert(prevLetter(StartLetter)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Print the instructions for playing the game.
printInstructions :-
	nl,
	write('Welcome to the Alphabet Game.'),
	nl,
	nl,
	write('You will be shown a letter of the alphabet and then asked to'),
	nl,
	write('enter the next three letters that follow it,'),
	write('in alphabetical order.'),
	nl,
	write('Please enter all letters in lower case only, one at a time.'),
	nl,
	write('Enter ''z'' to quit at any point during the game.'),
	nl,
	nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prompt for, read, and get a letter, and clean the newline
promptGetInput(N, Char) :-
	prevLetter(CurrentLetter),
	write(N),
	write(' Enter the letter that follows '''),
	name(LetterName, [CurrentLetter]),
	write(LetterName),
	write(''':  '),
	get0(Char), %gets character from user
	get0(_).%clears newline

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1st: If z, quit game.
% 2nd: move the character along, accepting
% it as correct.
% 3rd: Call replay on invalid entry
%
% This predicate is order dependent
% if prolog was order independant then this would be an error
move(_, Char) :-
	Char == 122, %'z'
	write('Exiting the alphabet game.'), 
	nl,
	!.

move(N, Char) :-
	%Char != 122, %'z'
	alphaL(Char),
	isNext(N, Char).

move(N, _) :-
	replay(N).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This predicate is order dependent
alphaL(Char) :-
	lowerCaseAlpha(LowerCaseLetters),
	member(Char, LowerCaseLetters).
        %RH modified this line.  was "abcdefghijklmnopqrstuvwxyz"

alphaL(Char) :-
	write(''''), % print a single quote mark
	put(Char),
	write(''' is not a lower-case letter of the alphabet.'),
	nl,
	fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% True is Char is the next letter of the alphabet
%
% This predicate is order dependent
isNext(N, Char) :-
	prevLetter(Prev),
	Char is Prev + 1,
	retract(prevLetter(Prev)),
	assert(prevLetter(Char)),
	next_move(N).

isNext(_, _) :-
	write('That''s not the next letter in alphabetical order.'),
	nl,
    fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check to see if player has won.
%
% This predicate is order dependent
next_move(N) :-
	N == 3,
	write('YOU WIN. You correctly entered letters in alphabetical order.'),
	nl.

next_move(N) :-
	N1 is N + 1,
	play(N1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get new input, without increasing round number
replay(N) :-
	write('Please try again.'),
	nl,
	nl,
	play(N).