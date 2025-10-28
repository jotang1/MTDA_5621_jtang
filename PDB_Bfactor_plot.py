#!/usr/bin/python3

# install biopython module
from Bio.PDB import PDBParser
import matplotlib.pyplot as plt
import argparse

def main():
    parser = argparse.ArgumentParser(description="Verify the predicted structure from B-factor in PDB")
    parser.add_argument('--input_file_path', '-i', required=True, default='.', help="pickle file")
    
    args = parser.parse_args()
    
    pdb_file = open(args.input_file_path, 'r')
    parser = PDBParser()
    structure = parser.get_structure("protein_name", pdb_file)

    b_factors = []
    
    for atom in structure.get_atoms():
        if atom.element != "H":  # skip hydrogens if present
            b_factors.append(atom.bfactor)

    plt.plot(b_factors)
    plt.title("pLDDT Scores from B-factor")
    plt.ylabel("pLDDT")
    plt.xlabel("Atom Index")
    plt.show()
    
if __name__ == "__main__":
    main()
