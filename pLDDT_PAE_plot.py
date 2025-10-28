#!/usr/bin/python3

# Joseph Tang @ Ohio Supercomputer Center, Oct/2025

# Numpy version < 2.0

import pickle
import matplotlib.pyplot as plt
import argparse
import numpy as np
import pandas as pd
from pathlib import Path

def main():
    parser = argparse.ArgumentParser(description="Create pLDDT and PAE plots and export summary stats.")
    parser.add_argument("-i", "--input_file_path", required=True, help="Path to result_model_*.pkl")
    parser.add_argument("-o", "--output_dir", default=".", help="Directory to save plots and summary CSV")
    
    args = parser.parse_args()
    file_path = Path(args.input_file_path)
    with open(file_path, 'rb') as f:
        data = pickle.load(f)
            
    out_dir = Path(args.output_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    # Find the keys in the pickle files:
    #print(data.keys())

    plddt = data['plddt']
    pae = data['predicted_aligned_error']
    
    mean_plddt = round(float(np.mean(plddt)), 3)
    sd_plddt = round(float(np.std(plddt)), 3)
    seq_len = np.size(plddt)
    accession  = file_path.parent.name
    model_name = file_path.stem

    # Plot pLDDT
    plt.figure(figsize=(6, 5))
    plt.plot(plddt)
    plt.xlabel('Residue Index')
    plt.ylabel('pLDDT')
    plt.title('pLDDT Confidence per Residue')
    plt.title(f"{accession} - {model_name} pLDDT Confidence per Residue")
    plt.grid()
    plt.tight_layout()
    plt.savefig(out_dir / f"{accession}_{model_name}_pLDDT.png", dpi=300)
    plt.show()
    plt.close()

    # Plot PAE
    plt.figure(figsize=(5, 4.5))
    plt.imshow(pae, cmap='viridis', interpolation='nearest')
    plt.title('Predicted Aligned Error (PAE)')
    plt.colorbar(label='Error (Å)')
    plt.xlabel('Residue Index')
    plt.ylabel('Residue Index')
    plt.tight_layout()
    plt.savefig(out_dir / f"{accession}_{model_name}_PAE.png", dpi=300)
    plt.show()
    plt.close()
    
    # Save summary to csv:
    summary_path= out_dir / "plddt_summary.csv"
    row = pd.DataFrame([{
        "Accession": accession,
        "Model": model_name,
        "Mean_pLDDT": mean_plddt,
        "SD_pLDDT": sd_plddt, 
        "sequence_length": seq_len 
    }])
    
    # append if exists:
    if summary_path.exists():
        row.to_csv(summary_path, mode="a", header=False, index=False)
    else:
        row.to_csv(summary_path, index=False)
    
    print(f"{accession}/{model_name}: Mean={mean_plddt:.2f}, SD={sd_plddt:.2f}, n={seq_len}")
    print(f"Saved plots and updated {summary_path}")
    
if __name__ == "__main__":
    main()
