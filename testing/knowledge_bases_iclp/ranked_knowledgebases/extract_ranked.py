import json 

for i in range(25,225,25):
    with open(f"ranked_{i}") as file:
        ranked = json.load(file)
    ranked_statements = ranked["Call"][0]["Witnesses"][0]["Value"]
    with open(f"ranked_{i}.lp","a+") as file:
        for statement in ranked_statements:
            file.writelines(f'{statement}.\n')