import clingo

ctl = clingo.Control()
models=[]
with open('rational_closure_encoding.lp') as file:
    encoding = file.read()


with open('rational_closure_instance.lp') as file:
    instance = file.read()


def run_rationalClosure(instances):
    ctl.add("base",[],instances)
    ctl.add("base",[],encoding)
    ctl.ground([("base", [])])
    with ctl.solve(yield_=True) as handle:
        for model in handle:
            models.append(model.symbols(shown=True))

def get_models():
    return models
   # returns the entailment of a procedure 
