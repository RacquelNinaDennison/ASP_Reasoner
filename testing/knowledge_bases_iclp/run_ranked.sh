#!/bin/bash


main_directory="ranked_knowledgebases"
mkdir -p "$main_directory"


for i in $(seq 1 1000);
do
    output_file="${main_directory}/ranked_25_run_${i}"
    clingo --outf=2 --quiet=1 "knowledge_base_25.lp" "base-rank.lp" > "${output_file}"
done



for i in $(seq 1 1000);
do
    output_file="${main_directory}/ranked_50"
    clingo --outf=2 --quiet=1 "knowledge_base_50.lp" "base-rank.lp" > "${output_file}"
done

for i in $(seq 1 1000);
do
    output_file="${main_directory}/ranked_100"
    clingo --outf=2 --quiet=1 "knowledge_base_100.lp" "base-rank.lp" > "${output_file}"
done
for i in $(seq 1 1000);
do
    output_file="${main_directory}/ranked_150"
    clingo --outf=2 --quiet=1 "knowledge_base_150.lp" "base-rank.lp" > "${output_file}"
done


