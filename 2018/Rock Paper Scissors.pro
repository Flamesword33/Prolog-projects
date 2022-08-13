% Rock Paper Scissors.pro
% by Nathan Pelletier
% published: November 26, 2018
%
% A user plays the computer in a game of rock paper scissors
% where rock beats scissors
% scissors beat paper
% and paper beats rock
%
% Needs to:
% Welcome the user DONE
% get the users input DONE
% get a random number from the computer DONE
% give the user feedback on the computers input,
% users input and who won DONE
% play for ten rounds DONE
% inputs are: r, p, s, R, P, S DONE
% must ask the user to try again on a bad input DONE
% indicates the game is over DONE
% gives feedback on how many wins, losses and ties were made DONE
%
% NOTE ORDER DEPENDENTS
% CAN NOT USE !
%
% NOTE TO SELF:
%   always pass a _ when recursing if its a variable else ends
%   recursion

%/////////
%//RULES//
%
% start
%   init
%   main(int)
%   welcomeUser
%   getUserInput(variable) --> char
%     isLowerCase(char, variable) --> char
%   failedInput(char, variable) --> char
%   getComputerInput(variable) --> char
%     elementAt(list, int, variable) --> char
%   printChoices(char, char)
%     convertCharToString(char)
%   whoWonThisRound(char, char)
%     findWinner(char, char) --> bool
%   gameOver()
%
%
%///////////
%//GLOBALS//
%
% userWins
% computerWins
% ties

:- dynamic(userWins/1).
:- dynamic(computerWins/1).
:- dynamic(ties/1).

%/////////
%//FACTS//
possibleComputerInputs([114, 112, 115]).%[r, p, s]

% start
%
% calls all other methods in order in rock paper scissors
start :-
    init,
    welcomeUser,
    main(0).

%init
%
%resets all globals to 0
init :-
    retractall(userWins(_)),
    retractall(computerWins(_)),
    retractall(ties(_)),
    assert(userWins(0)),
    assert(computerWins(0)),
    assert(ties(0)).


% main(int)
%
% continues to call methods while looping ten times
% ORDER INDEPENDANT
main(NumberOfRounds) :-
    NumberOfRounds < 10,
    NextRound is NumberOfRounds + 1,
    write('Round '),
    write(NextRound),
    write('. FIGHT'),
    nl,
    getUserInput(UserInput),
    failedInput(UserInput, CorrectedUserInput),
    getComputerInput(ComputerInput),
    printChoices(CorrectedUserInput, ComputerInput),
    whoWonThisRound(CorrectedUserInput, ComputerInput),
    main(NextRound).

main(FinalRound) :-
    FinalRound >= 10,
    gameOver.


% welcomeUser
%
% Announces the start of rock paper scissors to user
welcomeUser :-
    write('Welcome to a game of rock paper scissors'),
    nl,
    write('----------------------------------------'),
    nl.


% getUserInput(variable) --> char
%
% asks the user for input and returns a lower case character
getUserInput(UserInput) :-
    write('Make your choice (rock, paper or scissors): '),
    get_single_char(AlmostUserInput),
    isLowerCase(AlmostUserInput, UserInput),
    nl.


% isLowerCase(char, char) --> char
%
% takes a char and returns a lower case char(or symbol...)
% ORDER INDEPENDANT
isLowerCase(UserInput, UserInput) :-
    not(is_upper(UserInput)). %not is_upper covers lower case and symbols

isLowerCase(UpperCaseUserInput, LowerCaseUserInput) :-
    is_upper(UpperCaseUserInput),
    LowerCaseUserInput is UpperCaseUserInput + 32 . %R --> r


% failedInput(Char, Variable) --> Char
%
% checks if the input is r, p or s
% if it finds a bad input then the program asks for fresh input
% ORDER INDEPENDANT
failedInput(GoodInput, GoodInput) :-
    GoodInput =:= 114; %r or
    GoodInput =:= 112; %p or
    GoodInput =:= 115. %s

failedInput(BadInput, GoodInput) :-
    BadInput \== 114, %r and
    BadInput \== 112, %p and
    BadInput \== 115, %s
    write('What you entered wasn\'t a input I understand.'),
    nl,
    write('Please try again '),
    getUserInput(GoodInput),
    failedInput(GoodInput, _).


% getComputerInput(variable) --> char
%
% generates a random number and converts it to a char via
% the fact possibleComputerInputs
getComputerInput(ComputerInputChar) :-
    random_between(0,2,ComputerRandNum),
    possibleComputerInputs(AIndexForList),
    elementAt(AIndexForList, ComputerRandNum, ComputerInputChar).


% elementAt(list, int, variable) --> char
%
% parses through a list at the cost of a counter
% ORDER INDEPENDENT
elementAt([Head|_], 0, Result) :-
    Result is Head.
elementAt([_|Tail], Counter, Result) :-
    Counter > 0,
    Counter1 is Counter - 1,
    elementAt(Tail, Counter1, Result).


%printChoices(char, char)
%
% gives player feed back on who chose what
printChoices(User, Comp) :-
    write('You chose '),
    convertCharToString(User),
    nl,
    write('And the computer chose '),
    convertCharToString(Comp),
    nl,
    nl.


% convertCharToString
%
% changes r to rock
% p to paper
% s to scissors
convertCharToString(114) :-
    write('rock').
convertCharToString(112) :-
    write('paper').
convertCharToString(115) :-
    write('scissors').


% whoWonThisRound(char, char)
%
% determines who won and increments the correct counter

%if tie happens
whoWonThisRound(User, Comp) :-
    ties(T),
    User =:= Comp,
    Temp is T + 1,
    retract(ties(T)),
    assert(ties(Temp)),
    write('Tie'),
    nl, nl.

%if player wins
whoWonThisRound(User, Comp) :-
    userWins(UW),
    findWinner(User, Comp),
    Temp is UW + 1,
    retract(userWins(UW)),
    assert(userWins(Temp)),
    write('You win this round...'),
    nl, nl.

%if player loses
whoWonThisRound(User, Comp) :-
    computerWins(CW),
    findWinner(Comp, User),
    Temp is CW + 1,
    retract(computerWins(CW)),
    assert(computerWins(Temp)),
    write('Sorry but you can\'t win them all.'),
    nl, nl.


% findWinner(char, char) --> boolean
%
% assumes that a tie has been found
% returns true if the first char won
% requires 'r', 'p', 's'
findWinner(Winner, Loser) :-
    Winner =:= 114, %rock
    Loser =:= 115. %scissors

findWinner(Winner, Loser) :-
    Winner =:= 115, %scissors
    Loser =:= 112. %paper

findWinner(Winner, Loser) :-
    Winner =:= 112, %paper
    Loser =:= 114. %rock


% gamOver
%
% Gives the user feedback that the game is over
% Tells the user how many times they won, lost and tied
gameOver :-
    userWins(User),
    computerWins(Comp),
    ties(Ties),
    write('Game Over'),
    nl,
    nl,
    write('You won '),
    write(User),
    write(' times.'),
    nl,
    write('You tied '),
    write(Ties),
    write(' times.'),
    nl,
    write('You lost '),
    write(Comp),
    write(' times.').