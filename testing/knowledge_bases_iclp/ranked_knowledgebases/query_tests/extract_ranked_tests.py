import json 

prefix = 'ranked_query'
knowledge_base_count = [25,50,100,150]


for knowledge_base in knowledge_base_count:
    for i in range(1,1001):
        filename = f"{prefix}_{knowledge_base}_run_{i}"
        with open(filename) as file:
            jsonConverted = json.load(file)
        timeTaken = jsonConverted["Time"]["Total"]
        with open(f"results/{prefix}_{knowledge_base}","+a") as written_results:
            written_results.writelines(f"{timeTaken}\n")

    
