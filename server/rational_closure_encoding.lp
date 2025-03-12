% preprocessing on the ranks 
maximum_ranks(C) :- C = #count{N:rank(_,N)}. 
unique_rank(N) :- rank(_,N). 
subset(N):- unique_rank(N). 

% generate subsets  
{in_subset(X,N):subset(N)} :- rank(X,_). 

% define the subsets we are looking for 
rank_cardinality(N,C) :- unique_rank(N), C=#count{X:rank(X,N)}. 
subset_cardinality(N,C) :- C=#count{X:in_subset(X,N)},  in_subset(_,N). 
number_of_subsets(P):- P = #count{X:in_subset(_,X)}. 
C==P:- number_of_subsets(P), maximum_ranks(C). 
:- in_subset(X,N1), rank(X,N2), N1 > N2. 
subset_size(N, P) :- unique_rank(N), 
    P = #sum { C, R : rank_cardinality(R, C), R >= N }.
:- subset_cardinality(N,C), subset_size(N,P), C != P. 

% define inference relation amoung statements in subsets 
inference(X,X,N) :- in_subset(m_implication(X,Y),N). 
inference(X,Y,N) :- in_subset(m_implication(X,Y),N). 
inference(X,P,N) :- in_subset(m_implication(X,Y),N),in_subset(m_implication(Y,P),N), inference(X,X,N) .  

% exceptional set for the antecedent 
exceptional_set(N,X) :- inference(X,Y,N), in_subset(m_implication(X,-Y),N). 

entailed(true) :- inference(X,Y,N), query(X,Y), not exceptional_set(N,X).
entailed(false) :- not entailed(true). 

#show entailed/1.
