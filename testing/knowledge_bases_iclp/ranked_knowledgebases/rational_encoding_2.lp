rank(m_implication(b,f),0).
rank(m_implication(sp,f),2).
rank(m_implication(p,-f),1).
rank(m_implication(sp,p),2).
rank(m_implication(p,b),1).
% query(sp,f).
query(-sp,-b). 
in_subset(X,N):- rank(_,N), rank(X,N1), N1>=N.

% generating : guess some arbitary rank

{guess(N):rank(_,N)}=1.

 

% for each guess, we define the inferences we can draw from it

inference(X,X) :- rank(m_implication(X,Y),N1), guess(N), N<=N1.
inference(X,Y) :- rank(m_implication(X,Y),N1), guess(N), N<=N1.
inference(-Y,-X) :- rank(m_implication(X,Y),N1), guess(N), N<=N1.
inference(X,Z) :- inference(X,Y), rank(m_implication(Y,Z),N1), guess(N), N<=N1.

% X->Y and -X->Y implies Y is true.
inference(top,Y) :-inference(X,Y), inference(-X,Y).

% X->-Y and X->-Y implies X is false.
inference(top,-X) :-inference(X,Y), inference(X,-Y).
 
:- query(X,Y), inference(top, -X).

entailed(true):- inference(X,Y), query(X,Y).
entailed(false) :- not entailed(true).
% want to choose the minimal subset which will answer our query

#minimize{N:guess(N)}.

#show entailed/1.
 #show inference/2.
