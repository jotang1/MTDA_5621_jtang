# Gateway-Enabled AlphaFold Workflows for Teaching AI-Driven Structural Biology

## Overview


## Project Objectives
This repository contains educational materials, workflows, and supporting resources developed for the AlphaFold project in the 2026 Ohio Supercomputer Center (OSC) STEM Institute (SI). The materials were designed to introduce high school STEM students to AI-enabled structural biology through project-based investigations of p53 and the SARS-CoV-2 Spike protein.

## Workflow
<img width="200" height="400" alt="image" src="https://github.com/user-attachments/assets/37fe881a-7a1c-4a62-831d-889c7355131c" />

## Repository Contents
| Scripts | Functions |
| :--- | :--- |
| **fastas.py** | Extract one or more amino acid sequences |
| **AF_structure_SI2025.sh** | Access a singularity Apptainer created from Google AlphaFold2 repo | 
| **AF_msa_run.py** | Create MSAS files |
| **AF_full_run.py** | Create MSAS files, model files, PDB files |
| **AF_full_slurm.sh** | Execute AF_full_run.py via Slurm | 
| **run_analysis.py** | Select the best model and corresponding pdb and pickle files |
| **pLDDT_PAE_plot.py** | Create PLDDT and PAE plots and data analyses |
| **PDB_Bfactor_plot.py** | Create PLDDT store based on B-factor | 
| **run_full_AF2_pipeline.sh** | Execute the pipeline with a UniProID |

## Requirements
  - Python <br>
  - Shell scripts <br>
  - AlphaFold on Ohio Supercomputer Center HPC resources.<br>
  - PyMOL <br>
  - Open OnDemand (OOD)

## Running the Workflow
   ./run_full_AF2_pipeline.sh <UniProID>
   Output:
     - pdb files
     - pickel files

## Example Projects
   - p53
   - SARS-CoV-2 Spike

## Citation
   <TBD>
     
## Acknowledgments
