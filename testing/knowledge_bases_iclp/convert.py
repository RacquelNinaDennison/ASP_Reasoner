import re 

signatures =[]
with open("knowledge_base_150.lp") as file:
    statements_150 = file.readlines()


for statement in statements_150:
    matches = re.findall(r"a\((\d+)\)", statement)
    antecedent = matches[0]
    consequence = matches[1]
    if(antecedent not in signatures):
        signatures.append(antecedent)
    if(consequence not in signatures):
        signatures.append(consequence)

print(signatures)

with open("formated_hagen/asp_gen_150.cl","a+") as file:
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
    file.write("kb_gen150{\n")
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