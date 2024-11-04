#!/bin/bash

#SBATCH --job-name=test_job
#SBATCH --partition=teach_cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=0:10:00
#SBATCH --mem=100M
#SBATCH --account=SSCM033324

echo 'Setting up environment'

source ~/initMamba.sh

mamba activate ahds_week9

echo 'Starting analysis'

cd ~/ahds_practical/conda-hpc-snakemake-example/code/

Rscript 1_get_unique_conditions.R

{       read
        while IFS=, read -r line;
        do
                Rscript 2_find_side_effects.R "${line}"
                Rscript 3_plot_wordcloud.R "${line}"
        done

}< ../data/derived/top_conditions.csv

