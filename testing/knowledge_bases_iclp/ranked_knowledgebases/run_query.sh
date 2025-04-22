#!/bin/bash


main_directory="query_tests"
mkdir -p "$main_directory"

for j in $(seq 25 25 700);
    do
        for i in $(seq 1 2000);
        do
            output_file="${main_directory}/ranked_query_${j}_run_${i}_v2"
            clingo --outf=2 --quiet=1 "asp_files/knowledge_base_${j}.lp" "rational_encoding_2.lp" > "${output_file}"
        done
done