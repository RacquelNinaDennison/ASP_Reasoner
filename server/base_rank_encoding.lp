% material implication of statements 
implication(X,Y) :- defeasible(X,Y).
implication(X,Y) :- classical(X,Y).
statement_count(C):- C = #count{X,Y : implication(X,Y)}.
% ranking all classical statements on the infinite level 
rank(implication(X,Y),inf) :- classical(X,Y).
% preprocessing to define what an unsatifiable knowledge base is 
infer(X,Y) :- rank(implication(X,Y),N).
infer(X,P) :- rank(implication(Y,P),N1), infer(X,Y).
infer(top,Y) :- infer(X,Y), infer(-X,Y).

implication(X,Y) :- defeasible(X,Y).
statement_count(C) :- C=#count{X,Y: implication(X,Y)}.
{rank(implication(X,Y),0..C-1)} =1 :- statement_count(C), implication(X,Y), not classical(X,Y).

derive(X,Y,N) :- rank(implication(X,Y),N).
derive(X,P,N) :- rank(implication(Y,P),N1), derive(X,Y,N), N1 >= N.
derive(top,Y,N) :- derive(X,Y,N1), derive(-X,Y,N) , N1 >= N.

:- derive(X,Y,N), derive(X,-Y,N).
:- derive(-X,_,N), derive(top,X,N).
:- derive(_,-X,N), derive(top,X,N).
:- rank(implication(X,_),N1), rank(implication(X,_),N2), N1 != N2, not classical(X,_), not coded_classical(X,_).
:- infer(top,X), infer(-X,X). 
:- infer(top,Z), infer(top,X), infer(Z,-X). 


#minimize{N,X,Y : rank(implication(X,Y),N)}.
#minimize{N,Y : derive(top,Y,N)}.
#minimize{N,Y,X : derive(top,Y,N),rank(implication(-X,Y),N) , rank(implication(X,Y),N)}.

#show rank/2.

