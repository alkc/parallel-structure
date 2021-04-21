#!/usr/bin/env bash

# "parallel-structure.sh"
# Author: Alexander Koc <alexander.koc@slu.se>
# Version: 0.6 <2021-04-13>
# Description: Wrapper around structure allowing for parallel runs of multiple values of MAXPOP/K and replicates

# Usage:
# $ bash parallel-structure.sh path/to/mainparams path/to/extraparams path/to/input_data path/to/output_directory min_K max_K nbr_reps nbr_parallel_jobs

if [ "$#" -eq  "0" ]
then
    echo ""
    echo "parallel-structure.sh"
    echo ""
    echo "Author: Alexander Koc <alexander.koc@slu.se>"
    echo "Version: 0.6 <2021-04-13>"
    echo "Description: Wrapper around structure allowing for parallel runs of multiple values of MAXPOP/K and replicates"
    echo ""
    echo -e "\tUsage:"
    echo -e "\t$ bash run-structure-analysis.sh path/to/mainparams path/to/extraparams path/to/input_data path/to/output_directory min_K max_K nbr_reps nbr_parallel_jobs"
    echo ""
    echo "For more instructions/examples, please refer to: https://github.com/alkc/parallel-structure"
    echo ""
    exit 0
fi

# Check if parallel/structure are installed

# Big thanks to: https://stackoverflow.com/a/677212 !
if ! command -v structure &> /dev/null
then
    echo "structure could not be found. Make sure STRUCTURE 3.4 is installed and accessible in the bash environment prior to running this script!"
    exit 1
fi

if ! command -v parallel &> /dev/null
then
    echo "parallel could not be found. Make sure the latest version GNU parallel is installed on this system before running this script!"
    exit 1
fi

# Process script inputs:

mainparams="$1"
extraparams="$2"
inputdata="$3"
outputfolder="$4"
k_min=$5
k_max=$6
n_reps=$7
# Script parameters:
n_parallel_jobs="$8"


k_series=$(seq $k_min 1 $k_max)
rep_series=$(seq 1 1 $n_reps)

# Process settings:
function file_exists {

    file="$1"
    
    if [ ! -f "$file" ]
    then
	echo "[ERROR] $file does not exist."
	exit 1
    fi
    
}

function run_structure {

    rand_seed="$RANDOM"
    
    mainparams="$1"
    extraparams="$2"
    inputdata="$3"
    outputfolder="$4"
    curr_k="$5"
    curr_rep="$6"

    extraparams_tmp="/tmp/extraparams_K${curr_k}_REP${curr_rep}_${rand_seed}"

    cat ${extraparams} > ${extraparams_tmp}
    echo -e "" >> ${extraparams_tmp}
    echo -e "#define SEED $rand_seed" >> ${extraparams_tmp}

    sed '/RANDOMIZE/d' -i ${extraparams_tmp}
    echo -e "#define RANDOMIZE 0" >> ${extraparams_tmp}
    
    # cat $extraparams_tmp

    structure -m ${mainparams} -e ${extraparams_tmp} -i ${inputdata} -o ${outputfolder}/K${curr_k}_REP${curr_rep} -K ${curr_k} > ${outputfolder}/K${curr_k}_REP${curr_rep}.output.txt

    rm ${extraparams_tmp}
    
}

export -f run_structure

# Script start
echo "[START] Hello there."
echo "[INFO] Script running with following parameters:"
echo "[INFO] Input data: ${inputdata}"

file_exists $inputdata

echo "[INFO] Main parameter file: ${mainparams}"

file_exists $mainparams

echo "[INFO] Extra params file: ${extraparams}"

file_exists $extraparams

echo "[INFO] BTW. This file will be modified to add a random seed for each run. Custom seeds or RANDOMIZE=1 will be overriden."
echo "[INFO] Output set to be saved in: ${outputfolder}"

[ ! -d "$outputfolder" ] && echo "[INFO] Creating directory: $outputfolder" && mkdir -p $outputfolder

echo "[INFO] Script will run ${n_parallel_jobs} jobs."
echo "[INFO] Using Testing MAXPOP/K from K = ${k_min}-${k_max}"
echo "[INFO] $n_reps reps per K"
echo "[INFO] Buckle up. Starting the structure run in parallel." 

# Execute structure in parallel over $n_threads. 
parallel --progress -j ${n_parallel_jobs} run_structure ${mainparams} ${extraparams} ${inputdata} ${outputfolder} {1} {2} ::: "${k_series[@]}" ::: "${rep_series[@]}"

echo "[INFO] All structure runs completed. (... Alternatively, all structure runs exited with errors)."
echo "[EXIT] Bye."
