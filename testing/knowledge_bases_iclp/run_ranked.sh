#!/bin/bash

main_directory="ranked_knowledgebases"
mkdir -p "$main_directory"

for j in $(seq 25 25 700); do
    output_file="ranked_${j}.json"
    clingo --outf=2 --quiet=1 "asp_files/knowledge_base_${j}.lp" "base-rank.lp" > "${main_directory}/${output_file}"
done
