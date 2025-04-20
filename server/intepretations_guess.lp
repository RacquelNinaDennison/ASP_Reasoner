% Define the atoms
atom(p). atom(b). atom(f).
query(p,-f).  % Check if p entails f
rank(m_implication(b, f), 0).    % b → f with rank 0
rank(m_implication(p, b), 1).    % p → b with rank 1
rank(m_implication(p, -f), 1).   % p → ¬f with rank 1

% Define subset membership based on ranks
in_subset(X, N) :- rank(X, N1), rank(_, N), N1 >= N.

% Count the number of atoms
atom_count(N) :- N = #count{A : atom(A)}.

% Choose a rank for entailment checking
{guess(N) : rank(_, N)} = 1.

% Generate interpretation IDs dynamically (2^n combinations for n atoms)
interp_id(0..M-1) :- atom_count(N), M = 2**N.

% Convert IDs to binary representation for atoms
has_bit(ID, Pos, 1) :- interp_id(ID), atom_count(N), Pos = 0..(N-1),
                     ID/2**Pos - 2*(ID/2**(Pos+1)) = 1.
has_bit(ID, Pos, 0) :- interp_id(ID), atom_count(N), Pos = 0..(N-1),
                     not has_bit(ID, Pos, 1).

atom_pos(A, P) :- atom(A), P = #count{A1 : atom(A1), A1 < A}.
has_true(ID, A) :- interp_id(ID), atom(A), atom_pos(A, Pos), has_bit(ID, Pos, 1).
has_false(ID, A) :- interp_id(ID), atom(A), atom_pos(A, Pos), has_bit(ID, Pos, 0).

% Define negation
has_true(ID, -A) :- interp_id(ID), atom(A), has_false(ID, A).
has_false(ID, -A) :- interp_id(ID), atom(A), has_true(ID, A).

% Check if a material implication is satisfied in an interpretation
satisfied_impl(ID, X, Y) :- rank(m_implication(X, Y), _), interp_id(ID), has_false(ID, X).
satisfied_impl(ID, X, Y) :- rank(m_implication(X, Y), _), interp_id(ID), has_true(ID, X), has_true(ID, Y).

% Check if a ranked implication is satisfied
satisfied(ID, m_implication(X, Y)) :- rank(m_implication(X, Y), _),
                               interp_id(ID), satisfied_impl(ID, X, Y).

valid_for_rank(ID, N) :-
    interp_id(ID),
    rank(_, N),
    #count{X,Y : in_subset(m_implication(X,Y), N), not satisfied(ID, m_implication(X,Y))} = 0.

interp_result(ID, N, A, true) :- valid_for_rank(ID, N), atom(A), has_true(ID, A).
interp_result(ID, N, A, false) :- valid_for_rank(ID, N), atom(A), has_false(ID, A).

valid_model(ID, N) :- valid_for_rank(ID, N), guess(N).

% Check if there's any model where X is true
has_x_true_model :- query(X,_), valid_model(ID, N), interp_result(ID, N, X, true).

% One interpretation which contradicts the model
counterexample(ID) :- query(X,Y), valid_model(ID, N), 
                     interp_result(ID, N, X, true), 
                     interp_result(ID, N, Y, false).

% Entailment conditions:
% 1. There's at least one model where X is true
% 2. There's no counterexample (no model where X is true and Y is false)
entailed(true) :- has_x_true_model, not counterexample(_).
entailed(false) :- not entailed(true).

% Show results
#show entailed/1.
#show guess/1.