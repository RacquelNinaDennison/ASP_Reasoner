import clingo

ctl = clingo.Control()
models = []

# Read base encoding
with open("base_rank_encoding.lp") as file:
    base_rank_encoding = file.read()

def run_base_rank(instance):
    global models
    models = [] 

    ctl = clingo.Control()  
    ctl.add("base", [], instance)
    ctl.add("base", [], base_rank_encoding)  #
    ctl.ground([("base", [])])  

    with ctl.solve(yield_=True) as handle:
        for model in handle:
            models.append(". ".join(str(atom) for atom in model.symbols(shown=True))) 

def get_base_rank_models(instance):
    run_base_rank(instance=instance)
    last_model = models[-1] if models else ""  
    return last_model if last_model.endswith(". ") else last_model + "."