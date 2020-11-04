#!/usr/bin/env bash

# Author: Alexander Koc <alexander.koc@slu.se>
# Version: 0.4 <2020-11-04>
# Description: Wrapper around structure allowing for parallel runs of multiple values of MAXPOP/K and replicates

# Usage:
# $ bash run-structure-analysis.sh path/to/mainparams path/to/extraparams path/to/input_data path/to/output_directory

# Script parameters:
mainparams="$1"
extraparams="$2"
inputdata="$3"
outputfolder="$4"

# TODO: Allow setting of these from cmd line
# Number of parallel processes to run:
n_threads=18

# MAXPOP/K interval to try
k_min=1
k_max=10

# Number of replicate runs per K:
n_reps=10

# Script start
echo "[START] Hello there."
echo "[INFO] Script running with following parameterss:"
echo "[INFO] Input data: ${inputdata}"
echo "[INFO] Main parameter file: ${mainparams}"
echo "[INFO] Weird extra params file: ${extraparams}"
echo "[INFO] Output set to be saved in: ${outputfolder}"
echo "[INFO] Using ${n_threads} threads."
echo "[INFO] Using Testing MAXPOP/K from K = ${k_min}-${k_max}"
echo "[INFO] $n_reps reps per K"
echo "[INFO] Buckle up. Starting the structure run in parallel." 

# Execute structure in parallel over $n_threads. 
echo "[INFO] Executing following command:"
echo "[INFO] parallel --progress -j ${n_threads} structure -m ${mainparams} -e ${extraparams} -i ${inputdata} -o ${outputfolder}/k{1}_run_{2} -K {1} '>' ${outputfolder}/k{1}_run_{2}.output.txt ::: {$k_min..$k_max} ::: {01..$n_reps}"

parallel --progress -j ${n_threads} structure -m ${mainparams} -e ${extraparams} -i ${inputdata} -o ${outputfolder}/k{1}_run_{2} -K {1} '>' ${outputfolder}/k{1}_run_{2}.output.txt ::: {$k_min..$k_max} ::: {01..$n_reps}

echo "[INFO] All structure runs completed. (... Alternatively, all structure runs exited with errors)."
echo "[EXIT] Bye."
