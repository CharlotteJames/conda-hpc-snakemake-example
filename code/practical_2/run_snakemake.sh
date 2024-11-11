#!/bin/bash

#SBATCH --job-name=test_job
#SBATCH --partition=teach_cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=0:10:00
#SBATCH --mem=100M
#SBATCH --account=SSCM033324
#SBATCH --output ./slurm_logs/%j.out


cd "${SLURM_SUBMIT_DIR}"

echo 'Setting up environment'

source ~/initConda.sh

mamba activate ahds_week9

mkdir -p ./slurm_logs/

cd ../

echo 'Starting snakemake'

time snakemake -j1
