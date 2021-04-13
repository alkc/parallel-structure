# parallel-structure

Glued-together bash script for running parallel runs "Structure" for population genetics inference for different values of `K` and reps.

You will need both `parallel` and structure installed — an easy task with conda:

```
conda install -c bioconda parallel structure
```

## Example

To check if the script works, please use the included example data set (borrowed from the structure website)

Please run the following command from the script directory:

```
bash parallel-structure.sh example-data/mainparams example-data/extraparams example-data/testdata1 output_dir 1 3 5 8
```

The command starts 8 parallel jobs for K=1 to K=3 with 5 replicates for each tested value K.


## CHANGELOG

## New in version 0.6 <2021-04-13>

* FIXED bug where replicate runs started with the same seed, which defeated the purpose of reps.
* ADDED Ability to set min K, max K, number of reps and number of parallel jobs from the command line
* ADDED More informative error messages if files missing at specified paths  
