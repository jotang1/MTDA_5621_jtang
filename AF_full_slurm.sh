#!/bin/bash

#SBATCH -A {account} 
#SBATCH --job-name=AF_MTDA5621 
#SBATCH --partition=gpu 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gpus=1 
#SBATCH --cpus-per-task=4
#SBATCH --mem=64G 
#SBATCH --time=01:00:00

list=“fastas.file”
for protein in $(cat “$list”); do python AF_full_run.py $protein; done
