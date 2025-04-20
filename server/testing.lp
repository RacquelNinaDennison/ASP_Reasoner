atom(p).
atom(b).
atom(f).
statement(b,f).
statement(p,b).
statement(p,-f).
% Count the number of atoms
atom_count(N) :- N = #count{A : atom(A)}.

% Generate combination IDs (2^n combinations for n atoms)
combination_id(0..M-1) :- atom_count(N), M = 2**N.
amount_id(C) :- C = #count{ID : combination_id(ID)}.
% Convert IDs to binary representation for atoms
has_bit(ID, Pos, 1) :- combination_id(ID), atom_count(N), Pos = 0..N-1,
                     ID/2**Pos - 2*(ID/2**(Pos+1)) = 1.
has_bit(ID, Pos, 0) :- combination_id(ID), atom_count(N), Pos = 0..N-1,
                     not has_bit(ID, Pos, 1).

% Assign atoms to positions (any order works)
atom_pos(A, P) :- atom(A), P = #count{A1 : atom(A1), A1 < A}.

% Generate combinations based on bit patterns
combination(ID, A) :- combination_id(ID), atom(A), atom_pos(A, Pos), has_bit(ID, Pos, 1).
combination(ID, -A) :- combination_id(ID), atom(A), atom_pos(A, Pos), has_bit(ID, Pos, 0).
interpretation(X,Y,ID) :- statement(X,Y), combination(ID,X), combination(ID,Y). 
{interpretation(-X,-Y,ID);interpretation(-X,Y,ID)} :- statement(X,Y), combination(ID,-X), combination(ID,-Y). 
% Show which statements are satisfied by which combinations
:- interpretation(X,Y,_), interpretation(X,-Y,_).
:- interpretation(X,Y,0..C), statement(X,-Y), amount_count(C).

#show combination/2.
#show interpretation/3.
