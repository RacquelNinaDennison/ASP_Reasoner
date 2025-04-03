#!/bin/bash


main_directory="query_tests"
mkdir -p "$main_directory"

for j in $(seq 25 25 200);
    do
        for i in $(seq 1 1000);
        do
            output_file="${main_directory}/ranked_query_${j}_run_${i}"
            clingo --outf=2 --quiet=1 "ranked_${j}.lp" "rational_closure_encoding.lp" > "${output_file}"
        done
done