# Protein Modeling Workflows with AlphaFold

## Overview
This repository serves as the working archive for my protein modeling projects. It contains Python and shell scripts, workflows, protein sequence (FASTA) files, generated protein structure models (PDB and PKL files), processed graphics (pLDDT and PAE plots), and supporting materials developed for protein structure prediction and analysis.

The repository has evolved through multiple projects, including Python programming coursework, the Ohio Supercomputer Center (OSC) STEM Institute Protein Modeling project, and ongoing explorations in computational structural biology. It is intended to support future development, experimentation, and reuse of these workflows.

During the 2026 OSC STEM Institute, selected scripts and workflows from this repository were used to introduce high school students to AI-enabled protein structure prediction, molecular visualization, and computational structural biology

## Project Activities / Components:
  - Create protein structures using AlphaFold <br>
  - Visualize structures with PyMOL <br>
  - Compare predicted models with experimental PDB structures <br>
  - Analyze pLDDT confidences

## Workflow
<img width="240" height="400" alt="image" src="https://github.com/user-attachments/assets/37fe881a-7a1c-4a62-831d-889c7355131c" />

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
  - Sequencing Databases
  - Structural Databases
  - AlphaFold Container
  - PyMOL
  - Access to GPU nodes in HPC resources (e.g., Open OnDemand (OOD))

## Running the Workflow
    ./run_full_AF2_pipeline.sh <UniProID>
    
    Pipeline
    ↓
    Download FASTA
    ↓
    Generate MSA
    ↓
    Create Models
    ↓
    Analyze Results (pLDDT, PAE)
    ↓
    Visualization (PyMOL)

## Example Projects
  - p53 (protein oligomerization and DNA binding) <br>
  - SARS-CoV-2 Spike (wild-type versus S2P variant)

## Citation
   <TBD>
     
## Acknowledgments
