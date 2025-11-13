# conda-hpc-snakemake-example

-------------------------------

## Overview

The pipeline in this repository analyses data collected from online reviews of prescribed medications.

Specifically, it:
1. Identifies the 4 most common conditions experienced by people writing reviews
2. Finds words and bigrams used when describing the side effects of medications prescribed for each condition
3. Plots wordclouds to visualise the most common words and bigrams used to describe the side effects associated with these medications

## Homework (week 8)

Before week 9, you need to:

1. Create an SSH key for logging into BluePebble and GitHub
2. Add the SSH key to the SSH agent on your computer
3. Upload your public SSH key to GitHub
4. Edit the `~/.ssh/config` file on your computer so that you use SSH to login to BluePebble
5. Fork this repository, and clone the fork to your `$WORK` partition on BluePebble using git
6. Run the `installConda.sh` script in the `/code/setup/` directory to install conda on BluePebble

Instructions to do these steps can be found in the homework from week 8. There will also be a drop-in session before week 9 teaching (9:30am - 10am) where we will help you complete this setup.



## Practical 1: Conda on HPC

### Create directories 

The repository contains a `code` directory. You will also need a directory for your data and results. On BluePebble, navigate to the cloned repository and create two directories:

- `data`
- `results`

Inside the `data` directory, you will need to create a sub-directory named `original`.

### Moving data to BluePebble

You can download the data needed to run the pipeline from blackboard. Once you have downloaded it to your local computer, you need to move it to BluePebble. You can do this using `scp` from your local terminal:

`scp drugLibTrain_raw.tsv USERNAME@bp1-login.acrc.bris.ac.uk:`

This will copy the data to your `$HOME` partition on BluePebble. On BluePebble, you will need to move it to the `data/original/` directory that you created.

### Creating your conda environment

1. On BluePebble, navigate to this repository and create a conda environment from environment.yml (`conda env create -f environment.yml`)
2. Activate the conda environment (`conda activate ahds_week9`)

### Run analysis using a conda environment

Look at `practical_1/run_analysis.sh`: this is a sumbission script to run the pipeline on BluePebble. It does not make use of Snakemake.

1. Add comments to the submission script, describing what each step does
2. Submit the submission script to the jobque (`qsub run_analysis.sh`)
3. Add, commit and push the results to git so that you can view the figures locally
4. **extension** Edit the submission script to run as an array job

## Practical 2: Snakemake on HPC

You will now re-run the analysis using Snakemake. First, navigate to the root directory and clear all derived data and results:

`rm -r ./results/`

`rm -r ./data/derived/`

### Adapt the bash pipeline to work with snakemake

Look at `code/Snakefile`: this is a snakemake workflow for the analysis.
1. Compare this to the commands in `run_analysis.sh`. What commands aren't executed by the Snakefile?
2. Execute snakemake with a dry run (`snakemake -n`) -- what error(s) do you see?
3. Look at `make_config.sh`: which parts of the pipeline are missing? Complete and execute.
4. Run snakemake with a dry run again -- the errors should have gone. 
5. Execute the snakemake workflow on the login node, timing how long it takes (`time snakemake -j1`)

### Run your workflow using a slurm profile

1. Create a Snakemake slurm profile and save this in your config directory: `~./config/snakemake/slurm_profile/config.yaml`. You can find a template in the root directory of the repository.
2. Clean your Snakemake workflow (`snakemake clean`)
3. Run your workflow using your profile, timing it: `time snakemake --executor slurm --profile slurm_profile` 

## Things to consider

If you're making changes, consider raising an Issue in your forked github repository, creating a new branch, checking out that new branch and committing and pushing the changes there, then making a pull request.

Once finished, you could update this README.md to explain how to run your pipeline in different environments.


