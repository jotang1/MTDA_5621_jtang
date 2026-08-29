#!/bin/bash

#SBATCH -A {account} 
#SBATCH --job-name=AF_workflow 
#SBATCH --partition=gpu 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gpus=1 
#SBATCH --cpus-per-task=16
#SBATCH --mem=128G 
#SBATCH --time=08:00:00

list="fastas.file"
for protein in $(cat "$list"); do python AF_full_run.py $protein; done
