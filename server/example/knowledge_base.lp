defeasible(penguins,birds).
defeasible(birds,fly).
defeasible(penguins,-fly).
% defeasible(superpenguins,penguins).
% defeasible(superpenguins,fly).
% defeasible(tweety,birds).
query(-penguins,-birds).