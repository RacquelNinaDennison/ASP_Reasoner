#!/bin/bash


main_directory="ranked_knowledgebases"
mkdir -p "$main_directory"


output_file="${main_directory}/ranked_25"
clingo --outf=2 --quiet=1 "knowledge_base_25.lp" "base-rank.lp" > "${output_file}"

output_file="${main_directory}/ranked_50"
clingo --outf=2 --quiet=1 "knowledge_base_50.lp" "base-rank.lp" > "${output_file}"

output_file="${main_directory}/ranked_75"
clingo --outf=2 --quiet=1 "knowledge_base_75.lp" "base-rank.lp" > "${output_file}"

output_file="${main_directory}/ranked_100"
clingo --outf=2 --quiet=1 "knowledge_base_100.lp" "base-rank.lp" > "${output_file}"

output_file="${main_directory}/ranked_125"
clingo --outf=2 --quiet=1 "knowledge_base_125.lp" "base-rank.lp" > "${output_file}"

output_file="${main_directory}/ranked_150"
clingo --outf=2 --quiet=1 "knowledge_base_125.lp" "base-rank.lp" > "${output_file}"

output_file="${main_directory}/ranked_175"
clingo --outf=2 --quiet=1 "knowledge_base_125.lp" "base-rank.lp" > "${output_file}"

output_file="${main_directory}/ranked_200"
clingo --outf=2 --quiet=1 "knowledge_base_200.lp" "base-rank.lp" > "${output_file}"








