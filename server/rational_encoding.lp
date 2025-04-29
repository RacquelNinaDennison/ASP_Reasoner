% generating : guess some arbitary rank
{guess(N):rank(_,N)}=1.

% for each guess, we define the inferences we can draw from it
inference(X,X) :- rank(implication(X,Y),N1), guess(N), N<=N1.
inference(X,Y) :- rank(implication(X,Y),N1), inference(X,X), guess(N), N<=N1.
inference(X,Z) :- inference(X,Y), rank(implication(Y,Z),N1), guess(N), N<=N1.
inference(-Y,-X) :- rank(implication(X,Y),N1), guess(N), N<=N1.
inference(-Z,-X) :- inference(X,Y), rank(implication(Y,Z),N1), guess(N), N<=N1.

:- query(X,Y), inference(X,Y), inference(X,-Y).
entailed(true):- inference(X,Y), query(X,Y).
entailed(false) :- not entailed(true).
% want to choose the minimal subset which will answer our query
#minimize{N:guess(N)}.
#show entailed/1.