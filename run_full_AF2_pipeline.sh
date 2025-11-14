#!/bin/bash

# Run AF2 pipeline entering protein_id;
# USAGE: ./run_full_AF2_pipeline.sh $PROTEIN_ID

PROTEIN_ID=$1
WORKING_DIR=$2 

# DIRECTORIES
BASE_DIR="$WORKING_DIR/AF2_outputs"       # Where AF2 outputs are saved
OUTPUT_DIR="$WORKING_DIR/AF2_plots"       # Where renamed .pdb/.pkl go
FASTA_DIR="$WORKING_DIR/AF2_fastas"       # Where input FASTA files go
DATABASE="$WORKING_DIR/MTDA5621/uniprot_all_2021_04.fa"

# Create FASTA
echo "[1/4] Generating FASTA for $PROTEIN_ID"
python3 fastas.py -p $PROTEIN_ID -o $FASTA_DIR -d $DATABASE

# wait for fastas file being created:
EXPECTED_FASTA="${FASTA_DIR}/${PROTEIN_ID}.fasta"
echo "[1b/4] Waiting for fasta file to be created"
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
echo "[2b/4] Waiting for relaxed PDB to be created"
while [ -z "$(ls $EXPECTED_PDB 2>/dev/null)" ]; do
    sleep 60
    echo "waiting for output files"
done
echo "PDB file found, continuing."

# Copy best model and rename its pdb and pkl files:
echo "[3/4] Selecting and renaming best PDB and PKL"
python3 run_analysis.py \
  --protein_id $PROTEIN_ID \
  --base_dir $BASE_DIR \
  --output_dir $OUTPUT_DIR

# Generate pLDDT/PAE Plots & Launch PyMOL
echo "[4/4] Visualizing with pLDDT, PAE, and PyMOL"
python3 pLDDT_PAE_plot.py -i ${OUTPUT_DIR}/${PROTEIN_ID}.pkl -o ${OUTPUT_DIR}
pymol ${OUTPUT_DIR}/${PROTEIN_ID}.pdb

echo "Pipeline finished for $PROTEIN_ID"
