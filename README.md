[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21927981.svg)](https://doi.org/10.5281/zenodo.21927981)
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
| **AF_container_wrapped.sh** | Access a singularity Apptainer created from Google AlphaFold2 repo |
| **AF_msa_run.py** | Create MSAS files |
| **AF_full_run.py** | Create MSAS files, model files, PDB files |
| **AF_full_slurm.sh** | Execute AF_full_run.py via Slurm | 
| **run_analysis.py** | Select the best model and corresponding pdb and pickle files |
| **pLDDT_PAE_plot.py** | Create PLDDT and PAE plots and data analyses |
| **PDB_Bfactor_plot.py** | Create PLDDT store based on B-factor | 
| **run_full_AF2_pipeline.sh** | Execute the pipeline with a UniProID |
| **run_full_AF2_pipeline_custom.sh** | Execute the pipeline with a user-supplied FASTA |

## Requirements
  - Python <br>
  - Sequencing Databases
  - Structural Databases
  - AlphaFold Container
  - PyMOL
  - Access to GPU nodes in HPC resources (e.g., Open OnDemand (OOD))

### Computational Infrastructure & Reproducibility

To ensure the highest degree of structural accuracy and hardware optimization, this study utilizes a custom-built Apptainer (Singularity) environment. 

* **Custom Build Architecture**: The container features a modernized AlphaFold 2.3.2 source tree, refactored to support NVIDIA H100 architectures via OpenMM 7.7.0 and CUDA 11.8.0.
* **Infrastructure Independence**: The workflow is engineered to be fully portable, bypassing reliance on host-specific software stacks and ensuring long-term bit-for-bit reproducibility.
* **Verification**: This environment has been independently verified at the OSC to resolve legacy atom-indexing artifacts and compiler errors present in standard AF2 distributions.

## Running the Workflow
    # With UniProID:
    ./run_full_AF2_pipeline.sh <UniProID>

    # With a user-supplied FASTA:
    ./run_full_AF2_pipeline_custom.sh <CustomProID>
    
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

## Example Result:
Global mean pLDDT score and RMSD of AF-generated Spike protein models and comparison of reported structure 6VSB
| Model* | Global mean pLDDT score | Model* vs. 6VSB | RMSD (Å) |
| :--- | :--- | :--- | :--- |
| AF-WT S1 subunit | 90.12 | AF-WT S1 monomer vs. 6VSB S1 monomer | 1.902 |
| AF-WT S2 subunit | 77.66 | AF-S2P S1 monomer vs. 6VSB S1 monomer | 1.639 |
| AF-WT monomer | 76.50 | AF-WT S2 monomer vs, 6VSB S2 monomer | 1.313 |
| AF-S2P S1 subunit | 91.10 | AF-S2P S2 monomer vs 6VSB S2 monomer | 0.509 |
| AF-S2P S2 subunit | 87.10 | AF-WT monomer vs. 6VSB monomer | 1.749 |
| AF-S2P monomer | 80.50 | AF-S2P monomer vs. 6VSB monomer | 1.714 |
* AF-WT and AF-S2P represent the AlphaFold-generated wild-type and S2P variant of the Spike protein.

## Citation
   If you use this workflow or code, please cite:

  Tang, J. (2026). *Protein Modeling Workflows with AlphaFold*
  (Version v1.1.0) [Computer software]. Zenodo.
  https://doi.org/10.5281/zenodo.2192798

  The GitHub repository may contain updates made after the archived Zenodo release.
     
## Acknowledgments
   High-performance computing resources provided by the Ohio Supercomputer Center (OSC), a member of the Ohio Technology Consortium.
