% the general idea is to define subsets based on the ranking structure
% there after, we define the models associated with each ranking structure
% then we define entailment based on the models and exceptional ranks 

% Define subset membership based on ranks
in_subset(X, N) :- rank(X, N1), rank(_, N), N1 >= N.

% Count the number of atoms and get the highest rank
atom_count(N) :- N = #count{A : atom(A)}.
max_rank(M) :- M = #max{R : rank(_, R)}.

% Generate interpretation IDs (2^n combinations for n atoms)
interp_id(0..M-1) :- atom_count(N), M = 2**N.

% Convert IDs to binary representation for atoms, this essentially is modelling the truth values for the 
% atoms within the knowledge base 
has_bit(ID, Pos, 1) :- interp_id(ID), atom_count(N), Pos = 0..(N-1), ID/2**Pos - 2*(ID/2**(Pos+1)) = 1.
has_bit(ID, Pos, 0) :- interp_id(ID), atom_count(N), Pos = 0..(N-1), not has_bit(ID, Pos, 1).

% assigning truth values to the atoms based on their bit association 
atom_pos(A, P) :- atom(A), P = #count{A1 : atom(A1), A1 < A}.
has_true(ID, A) :- interp_id(ID), atom(A), atom_pos(A, Pos), has_bit(ID, Pos, 1).
has_false(ID, A) :- interp_id(ID), atom(A), atom_pos(A, Pos), has_bit(ID, Pos, 0).

% When a model satisfies an intepretation 
satisfies(ID, m_implication(X,Y)) :- 
    interp_id(ID), has_false(ID,X), in_subset(m_implication(X,Y),_).
satisfies(ID, m_implication(X,Y)) :- 
    interp_id(ID), has_true(ID,Y), in_subset(m_implication(X,Y),_).
satisfies(ID, m_implication(X,-Y)) :- 
    interp_id(ID), has_false(ID,X), in_subset(m_implication(X,-Y),_).
satisfies(ID, m_implication(X,-Y)) :- 
    interp_id(ID), has_false(ID,Y), in_subset(m_implication(X,-Y),_).

% which models satify the subsets of the ranked model 
satisfies_subset(ID, N) :- 
    interp_id(ID),
    rank(_, N),
    #count{I : in_subset(I,N), not satisfies(ID,I)} = 0.

% pushing the worlds down 
minimal_satisfied_rank(ID, N) :-
    interp_id(ID),
    satisfies_subset(ID, N),
    #count{R : rank(_, R), satisfies_subset(ID, R), R < N} = 0.

% those models which do not satisfy any subsets are impossible worlds 
impossible_worlds_rank(N+1) :- max_rank(N).
minimal_satisfied_rank(ID, N) :-
    interp_id(ID),
    impossible_worlds_rank(N),
    #count{R : rank(_, R), satisfies_subset(ID, R)} = 0.
model_in_subset(ID, N) :- minimal_satisfied_rank(ID, N).
model_has(ID, A) :- interp_id(ID), has_true(ID, A).
model_has(ID, -A) :- interp_id(ID), has_false(ID, A).
% negation queries 
lit_true (ID,  A) :- has_true (ID,A).
lit_true (ID, -A) :- has_false(ID,A).
lit_false(ID,  A) :- has_false(ID,A).
lit_false(ID, -A) :- has_true (ID,A).

% exceptional ranks are those that entail the negation of alpha when asking if alpha |~ beta holds 
exceptional(0,X) :-
    query(X,_),
    #count{ ID : interp_id(ID),
             model_in_subset(ID,0),
             lit_true(ID,X) } = 0.

exceptional(N,X) :-
    N > 0,
    exceptional(N-1,X),
    #count{ ID : interp_id(ID),
             model_in_subset(ID,N),
             lit_true(ID,X) } = 0.

% rank where the query is not exceptional and ensures all worlds are pushed down
rank_of_query(R) :-
    rank(_,R),                  
    query(X,_),
    not exceptional(R,X),         
    #count{K : rank(_,K),         
            K < R,
            not exceptional(K,X)} = 0.
entailed(true) :-
    query(X,Y),
    rank_of_query(R),          
    max_rank(M),            
    R < M+1,                  
    #count{ ID :
            interp_id(ID),
            model_in_subset(ID,R),
            lit_true (ID,X),
            lit_false(ID,Y) } = 0.

entailed(false) :- not entailed(true).
#show entailed/1.