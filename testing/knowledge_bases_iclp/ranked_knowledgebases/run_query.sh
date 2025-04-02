#!/bin/bash


main_directory="query_tests"
mkdir -p "$main_directory"


for i in $(seq 1 1000);
do
    output_file="${main_directory}/ranked_query_25_run_${i}"
    clingo --outf=2 --quiet=1 "ranked_25.lp" "rational_closure_encoding.lp" > "${output_file}"
done


for i in $(seq 1 1000);
do
    output_file="${main_directory}/ranked_query_50_run_${i}"
    clingo --outf=2 --quiet=1 "ranked_50.lp" "rational_closure_encoding.lp" > "${output_file}"
done

for i in $(seq 1 1000);
do
    output_file="${main_directory}/ranked_query_100_run_${i}"
    clingo --outf=2 --quiet=1 "ranked_100.lp" "rational_closure_encoding.lp" > "${output_file}"
done

for i in $(seq 1 1000);
do
    output_file="${main_directory}/ranked_query_150_run_${i}"
    clingo --outf=2 --quiet=1 "ranked_150.lp" "rational_closure_encoding.lp" > "${output_file}"
done
