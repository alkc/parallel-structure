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

In the last four digits of the above command you are able to set, in the following order: minimum K, maximum K, number of repetitions and number of parallel jobs. 

The command starts 8 parallel jobs for K=1 to K=3 with 5 replicates for each tested value K.

All  output is saved to `output_dir/`

## Citation

[![DOI](https://zenodo.org/badge/125206866.svg)](https://zenodo.org/badge/latestdoi/125206866)

* Add parallel citation here
* Add Structure citation here

## CHANGELOG

## version 0.6.1

* Prepare for release on Zenodo
* UPDATED README with better description

##  version 0.6 <2021-04-13>

* FIXED bug where replicate runs started with the same seed, which defeated the purpose of reps.
* ADDED Ability to set min K, max K, number of reps and number of parallel jobs from the command line
* ADDED More informative error messages if files missing at specified paths  
