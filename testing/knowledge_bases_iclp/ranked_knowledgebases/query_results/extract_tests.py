import json 

prefix = 'ranked_query'
knowledge_base_count = [25,50,75,125,100,150,175,200]


for knowledge_base in range(25,725,25):
    for i in range(1,2001):
        filename = f"query_tests/{prefix}_{knowledge_base}_run_{i}_v2"
        with open(filename) as file:
            jsonConverted = json.load(file)
        timeTaken = jsonConverted["Time"]["Total"]
        with open(f"results/{prefix}_{knowledge_base}.txt","+a") as written_results:
            written_results.writelines(f"{timeTaken}\n")
