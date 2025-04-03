import re 

for i in range(25,225,25):
    signatures =[]
    with open(f"knowledge_base_{i}.lp") as file:
        statements_150 = file.readlines()


    for statement in statements_150:
        matches = re.findall(r"a\((\d+)\)", statement)
        antecedent = matches[0]
        consequence = matches[1]
        if(antecedent not in signatures):
            signatures.append(antecedent)
        if(consequence not in signatures):
            signatures.append(consequence)
    with open(f"formated_hagen/asp_gen_{i}.cl","+a") as file:
        file.write("signature\n")
        file.write("\t")
        count = 0
        for signature in signatures:
            if(count == len(signatures)-1):
                file.write(f'a{signature}')
            else:
                file.write(f'a{signature},')
                count+=1
        file.write("\n")
        file.write("\n")
        file.write("conditionals")
        file.write("\n")
        file.write(f"kb_gen{i} {{\n")
        count=0
        for statement in statements_150:
            matches = re.findall(r"a\((\d+)\)", statement)
            antecedent = matches[0]
            consequence = matches[1]
            if(count == len(signatures)-1):
                file.write(f'(a{consequence}|a{antecedent})')
            else:
                file.write(f'(a{consequence}|a{antecedent}),\n')
                count+=1
        file.write("\n}")