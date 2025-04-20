% Extract atoms from your existing facts and rules
rank(m_implication(b, f), 0). 
rank(m_implication(t, b), 0).   
rank(m_implication(p, b), 1).   
rank(m_implication(p, -f), 1).  
% Extract atoms from ranked implications
% Extract atoms from implications
atom(X) :- rank(m_implication(X, _), _).
atom(X) :- rank(m_implication(_, X), _).
atom(Y) :- rank(m_implication(_, Y), _).
% This will identify atoms by looking at what appears in your m_implication facts
% and handle negated atoms by extracting the base atom

#show atom/1.