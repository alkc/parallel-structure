# parallel-structure

Glued-together bash script for running parallel runs "Structure" for population genetics inference for different values of `K` and reps.

You will need both `parallel` and structure installed — an easy task with conda:

```
conda install -c bioconda parallel structure
```

## Example

To check if the script works, please use the included example data set. More info about the sample data can be found at: https://web.stanford.edu/group/pritchardlab/software/structure-data_v.2.3.1.html (testdata1)

Please run the following command from the script directory:

```
bash parallel-structure.sh example-data/mainparams example-data/extraparams example-data/testdata1 output_dir 1 3 5 8
```

In the last four digits of the above command you are able to set, in the following order: minimum K, maximum K, number of repetitions and number of parallel jobs. 

The command starts 8 parallel jobs for K=1 to K=3 with 5 replicates for each tested value K.

All  output is saved to `output_dir/`

## Citation

[![DOI](https://zenodo.org/badge/125206866.svg)](https://zenodo.org/badge/latestdoi/125206866)

If this script has been useful to you and you think more researchers would benefit from knowing about it, then feel free to cite it at as follows: 

* Alexander Koc. (2021, April 16). alkc/parallel-structure: (Version v0.6.1). Zenodo. http://doi.org/10.5281/zenodo.4697229

More importantly, you should probably cite both structure and parallel on which this script relies.

For more info about how to cite Structure please refer to page 37 of the official [Structure 3.4 manual (PDF)](https://web.stanford.edu/group/pritchardlab/structure_software/release_versions/v2.3.4/structure_doc.pdf)

For more info about how to cite GNU parallel, please look here https://doi.org/10.5281/zenodo.1146014 (or run `parallel --citation` in the bash prompt!).

## CHANGELOG

## version 0.6.1

* Prepare for release on Zenodo
* UPDATED README with better description

##  version 0.6 <2021-04-13>

* FIXED bug where replicate runs started with the same seed, which defeated the purpose of reps.
* ADDED Ability to set min K, max K, number of reps and number of parallel jobs from the command line
* ADDED More informative error messages if files missing at specified paths  
