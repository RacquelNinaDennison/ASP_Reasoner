import json 

with open("ranked_50") as file:
    ranked_50 = json.load(file)

with open("ranked_100") as file:
    ranked_100 = json.load(file)

with open("ranked_25") as file:
    ranked_25 = json.load(file)

with open("ranked_150") as file:
    ranked_150 = json.load(file)



ranked_statements_50 = ranked_50["Call"][0]["Witnesses"][0]["Value"]
ranked_statements_100 = ranked_100["Call"][0]["Witnesses"][0]["Value"]
ranked_statements_25 = ranked_25["Call"][0]["Witnesses"][0]["Value"]
ranked_statements_150 = ranked_150["Call"][0]["Witnesses"][0]["Value"]


with open("ranked_100.lp","a+") as file:
    for statement in ranked_statements_100:
        file.writelines(f'{statement}.\n')

with open("ranked_50.lp","a+") as file:
    for statement in ranked_statements_50:
        file.writelines(f'{statement}.\n')

with open("ranked_25.lp","a+") as file:
    for statement in ranked_statements_25:
        file.writelines(f'{statement}.\n')

with open("ranked_150.lp","a+") as file:
    for statement in ranked_statements_150:
        file.writelines(f'{statement}.\n')