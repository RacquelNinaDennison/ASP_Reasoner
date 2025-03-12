from fastapi import FastAPI
from rational_closure import run_rationalClosure
from rational_closure import get_models
from base_rank import get_base_rank
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

class BaseRank(BaseModel):
    implications: str

class RationalClosureQuery(BaseModel):
    query:list[str]


app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],  # Adjust for your frontend port
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/entailment")
async def entailment(rationalClosure:RationalClosureQuery):
    run_rationalClosure(rationalClosure.query)
    models = get_models()
    result = ", ".join(str(symbol) for symbol in models[0])
    print(result)
    return {"message": result}

@app.post("/base-rank")
async def baserank(baserank:BaseRank):
    models= get_base_rank(baserank.implications)
    return {"message":models}
