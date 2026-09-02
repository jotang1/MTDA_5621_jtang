#!/bin/bash

# With a customized fasta file and protein_id
# USAGE: ./run_full_AF2_pipeline_custom.sh $PROTEIN_ID

PROTEIN_ID=$1
WORKING_DIR="/path/to/working/dir"

# DIRECTORIES
BASE_DIR="$WORKING_DIR/AF2_outputs"             # AF2 outputs (msas dir, pkl, pdb, and json files)
OUTPUT_DIR="$WORKING_DIR/AF2_plots"             # renamed .pdb/.pkl, pLDDT and PAE plots
FASTA_DIR="$WORKING_DIR/AF2_fastas"             # input FASTA files
DATABASE="/$WORKING_DIR/uniprot_all_2021_04.fa"

# Look for the fastas file:
EXPECTED_FASTA="${FASTA_DIR}/${PROTEIN_ID}.fasta"
echo "[1/4] Waiting for fasta file to be created"
while [ -z "$(ls $EXPECTED_FASTA 2>/dev/null)" ]; do
    sleep 10
    echo "waiting for fasta file"
done
echo "fasta file found, continuing."

# Run AlphaFold2
echo "[2/4] Submitting AF2 job for $PROTEIN_ID"
python3 AF_full_run.py $PROTEIN_ID

# Wait for pickle, pdb, and JSON files are created.
EXPECTED_PDB="${BASE_DIR}/${PROTEIN_ID}/relaxed_model_*.pdb"
echo "[2b/4] Waiting for relaxed PDB to be created..."
while [ -z "$(ls $EXPECTED_PDB 2>/dev/null)" ]; do
    sleep 60
    echo "waiting for output files"
done
echo "PDB file found, continuing."

# Copy Best Model Files
echo "[3/4] Selecting best PDB and PKL"
python3 run_analysis.py \
  --protein_id $PROTEIN_ID \
  --base_dir $BASE_DIR \
  --output_dir $OUTPUT_DIR

# Generate pLDDT/PAE Plots & Launch PyMOL
echo "[4/4] Visualizing with pLDDT, PAE, and PyMOL"
python3 pLDDT_PAE_plot.py -i ${OUTPUT_DIR}/${PROTEIN_ID}.pkl -o ${OUTPUT_DIR}
pymol ${OUTPUT_DIR}/${PROTEIN_ID}.pdb

echo "Pipeline finished for $PROTEIN_ID"
