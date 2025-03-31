import json 


with open("statements_25") as file:
    statements_25 = json.load(file)

with open("statements_50") as file:
    statements_50 = json.load(file)

with open("statements_100") as file:
    statements_100 = json.load(file)

with open("statements_150") as file:
    statements_150 = json.load(file)


defeasible_statements_25 = statements_25["Call"][0]["Witnesses"][0]["Value"]
defeasible_statements_50 = statements_50["Call"][0]["Witnesses"][0]["Value"]
defeasible_statements_150 = statements_150["Call"][0]["Witnesses"][0]["Value"]
defeasible_statements_100 = statements_100["Call"][0]["Witnesses"][0]["Value"]



with open("knowledge_base_25.lp","a+") as file:
    for statement in defeasible_statements_25:
        file.writelines(f'{statement}.\n')
        

with open("knowledge_base_50.lp","a+") as file:
    for statement in defeasible_statements_50:
        file.writelines(f'{statement}.\n')
        

with open("knowledge_base_100.lp","a+") as file:
    for statement in defeasible_statements_100:
        file.writelines(f'{statement}.\n')
        
with open("knowledge_base_150.lp","a+") as file:
    for statement in defeasible_statements_150:
        file.writelines(f'{statement}.\n')