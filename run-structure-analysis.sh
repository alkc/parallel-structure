#!/usr/bin/env bash

# Author: Alexander Koc <alexander.koc@slu.se>
# Version: 0.2 <2018-03-13>
# Description: The following script executes the structure software in parallel,
# and saves the output data and stdout data to separate files per run.

# Executable and input/output paths:

main_params="$1"
extra_params="$2"
input_data="$3"
output_folder="$4"
# basename="$5"

# Number of runs per K value:
n_reps=10

# Number of parallel processes to run:
n_threads=10

echo "[START] Hello."
echo "[INFO] Input data: ${input_data}"
echo "[INFO] Main parameter file: ${main_params}"
echo "[INFO] Extra parameter file: ${extra_params}"
echo "[INFO] Output saved in: ${output_folder}"
echo "[INFO] Using ${n_threads} threads."
echo "[INFO] Alright. Starting the structure run in parallel. Buckle up." 

parallel --progress -j ${n_threads} structure -m ${main_params} -e ${extra_params} -i ${input_data} -o ${output_folder}/k{1}_run_{2} -K {1} '>' ${output_folder}/k{1}_run_{2}.output.txt ::: {1..10} ::: {01..10}

echo "[INFO] Done!"
echo "[EXIT] Bye."
