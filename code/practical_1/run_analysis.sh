#!/bin/bash

#SBATCH --job-name=practical_1
#SBATCH --partition=teach_cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=0:10:00
#SBATCH --mem=100M
#SBATCH --account=SSCM037184
#SBATCH --output ./slurm_logs/%j.out


cd "${SLURM_SUBMIT_DIR}"

echo 'Setting up environment'

source ~/initConda.sh

conda activate ahds_week9

mkdir ./slurm_logs/
mkdir -p ../../results
mkdir -p ../../data/derived/intermediate

cd ../

Rscript 0_get_conditions.R

echo 'Starting analysis'


{       read
        while IFS=, read -r line;
        do
                Rscript 1_find_side_effects.R "${line}"
                Rscript 2_plot_wordcloud.R "${line}"
        done

}< ../data/derived/top_conditions.csv

echo 'Analysis complete'
