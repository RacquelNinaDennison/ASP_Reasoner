% defeasible(p,b).
% defeasible(p,-f).
% defeasible(b,f).
% defeasible(tweety,b).
% defeasible(sp,f).
% defeasible(sp,p).
% query(b,-f).

% defeasible(q,p).
% defeasible(-q,p).
% defeasible(p,r).
% defeasible(-r,s).
% query(-q,p).

defeasible(-q,p).
defeasible(q,p).
defeasible(p,r).
defeasible(-r,s).
defeasible(r,s).
defeasible(s,t).
defeasible(-t,x).
defeasible(z,-r).
defeasible(z,-s).
query(-p,q).
