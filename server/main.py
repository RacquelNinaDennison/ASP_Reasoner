from fastapi import FastAPI
from rational_closure import get_models_rational_clourse
from base_rank import get_base_rank_models
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

class BaseRank(BaseModel):
    implications: str

class RationalClosureQuery(BaseModel):
    query: str


app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.post("/entailment")
async def entailment(query:RationalClosureQuery):
    print(query.query)
    models = get_models_rational_clourse(query.query)
    print(models)
    return {"message": models}

@app.post("/base-rank")
async def baserank(baserank:BaseRank):
    print(baserank.implications)
    models= get_base_rank_models(baserank.implications)
    print(models)
    return {"message":models}
