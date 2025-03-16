import clingo


models=[]
with open('rational_closure_encoding.lp') as file:
    encoding = file.read()


with open('rational_closure_instance.lp') as file:
    instance = file.read()


def run_rationalClosure(instance):
    models.clear()
    ctl = clingo.Control()
    ctl.add("base",[],instance)
    ctl.add("base",[],encoding)
    ctl.ground([("base", [])])
    with ctl.solve(yield_=True) as handle:
        for model in handle:
            models.append(". ".join(str(atom) for atom in model.symbols(shown=True))) 

def get_models_rational_clourse(instance):
    print(instance)
    run_rationalClosure(instance)
    print(models)
    last_model = models[-1] if models else ""  
    return last_model if last_model.endswith(". ") else last_model + "."
 
