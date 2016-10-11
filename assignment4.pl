/**
 * Kaitlyn Cason
 * UCI CSE 141
 * 30 August 2016
 * UCI Student ID: 20282205
 */


/**
 * Question 1: Train Travel
 */

%Given knowledge base.
nonStopTrain(sandiego,oceanside).
nonStopTrain(lasvegas,sandiego).
nonStopTrain(sanfrancisco,bakersfield).
nonStopTrain(bakersfield,sandiego).
nonStopTrain(oceanside,losangeles).
nonStopTrain(portland,sanfrancisco).
nonStopTrain(seattle,portland).

%routeTrip exists from A to B if you can travel from A to B.
routeTrip(A, B, Trip):- routeTrip_(A, B, Trip, []).

%Base case: you can travel from A to B if there is a nonStopTrain 
% from A to B and the Reversed Path has B as its head, ie. 
% the path ends with B. Check if B has already been visited so you can't 
% travel from A to A if there is a cycle.
%Recursive case: you can travel from A to B if there is a nonStopTrain 
% from A to an intermediate point C, C hasn't already 
% been visited, and you can travel from C to B
routeTrip_(A, B, [A,B], Visited):- nonStopTrain(A, B), \+member(B,Visited).
routeTrip_(A,B,[A|Xs], Visited):- nonStopTrain(A, C), 
		\+member(C,Visited), routeTrip_(C, B, Xs, [A|Visited]).

%You can travel between A and B if there is a routeTrip from A to B
% and routeTrip from B to A.
canTravel(A, B):- routeTrip(A, B, _), routeTrip(B, A, _).


/**
 * Question 2: Seating Chart
 */

%Given knowledge base.
isMale(jim).
isMale(tom).
isMale(joe).
isMale(bob).

hobby(sue, yoga).
hobby(jim, chess).
hobby(tom, run).
hobby(tom, yoga).
hobby(joe, chess).
hobby(joe, run).
hobby(cami, yoga).
hobby(cami, chess).
hobby(cami, run).
hobby(bob, run).
hobby(fay, yoga).
hobby(fay, run).
hobby(fay, chess).
hobby(beth, chess).
hobby(beth, run).

%Added so that you have 24 correct seating arrangements 
% (without rotation repetition).
hobby(joe, yoga).

seatingChart([P1, P2, P3, P4, P5, P6, P7, P8]):-

	%Permute seats 1-8 over 8 names.
	permutation([P1, P2, P3, P4, P5, P6, P7, P8], [sue, jim, tom, joe, cami, bob, fay, beth]),
	%Collect a list of neighbor pairings.
	bagof([X,Y],circularneighbors(X,Y,[P1, P2, P3, P4, P5, P6, P7, P8]),CirList),
	%Check if each neighbor pairing is:
	% of opposite gender, and share a hobby.
	maplist(opGender,CirList),
	maplist(sameHobby,CirList).

%Make a circular list by appending the first element to the end of the list
circularneighbors(X,Y,[Z|Zs]):- append([Z|Zs],[Z],L), neighbors(X,Y,L).

%Find neighbors (right-aligned) in a list L.
%Base case: If the list is just [X,Y], then X and Y are neighbors.
%Recursive case: X and Y are neighbors if they are contained within
% list L (list L has a suffix starting with [X,Y]).
neighbors(X,Y,[X,Y]).
neighbors(X,Y,L):- append(_, [X,Y|_], L).

%True if adjacent partners are opposite genders
% (commits to avoid having to check the second predicate)
opGender([Head,Tail|[]]):- isMale(Head), not(isMale(Tail)), !;
	not(isMale(Head)), isMale(Tail).

%True if both adjacent partners share one hobby 
% (commits after we find one hobby to avoid redundant solutions)
sameHobby([Head,Tail|[]]):- hobby(Head, X), hobby(Tail, X),!.


