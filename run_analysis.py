#!/usr/bin/env python3

# Select the best model and renae it spbd and pkl files;
# Execution: python3 run_analysis.py --protein_id {PROTEIN_ID} --base_dir {BASE_DIR} --output_dir {OUTPUT_DIR}

import argparse
import os
import shutil
import json, subprocess

def get_best_model_id(ranking_path):
    with open(ranking_path) as f:
        data = json.load(f)
    # Sorted best to worst
    best_model_id = data["order"][0]
    return best_model_id

def copy_selected_files(protein_id, base_dir, output_dir):
    ranking_path = os.path.join(base_dir, f"{protein_id}", "ranking_debug.json")
    best_model = get_best_model_id(ranking_path)

    pdb_out = os.path.join(base_dir, f"{protein_id}", f"relaxed_{best_model}.pdb")
    pkl_out = os.path.join(base_dir, f"{protein_id}", f"result_{best_model}.pkl")

    os.makedirs(output_dir, exist_ok=True)

    shutil.copyfile(pdb_out, os.path.join(output_dir, f"{protein_id}.pdb"))
    shutil.copyfile(pkl_out, os.path.join(output_dir, f"{protein_id}.pkl"))

    print(f"Files ready in {output_dir} for protein {protein_id}")
    
    return pdb_out, pkl_out

def main():
    parser = argparse.ArgumentParser(description="select the best model and rename its pdb and pickle files")
    parser.add_argument("--protein_id", required=True, help="Protein ID")
    parser.add_argument("--base_dir", required=True, help="where AF2 results are stored")
    parser.add_argument("--output_dir", required=True, help="store renamed output")

    args = parser.parse_args()

    copy_selected_files(args.protein_id, args.base_dir, args.output_dir)
    
if __name__ == "__main__":
    main()
