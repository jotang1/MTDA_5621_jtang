#!/bin/bash
set -e

# --- Configuration ---
SIF_FILE="/fs/scratch/PZS1154/alphafold/scripts/alphafold_2.3.2.sif"
HOST_DATA_DIR="/fs/scratch/PZS1154/alphafold/databases"

# --- Performance Tuning ---
export TF_FORCE_UNIFIED_MEMORY=0
export XLA_PYTHON_CLIENT_MEM_FRACTION=4.0
export XLA_PYTHON_CLIENT_PREALLOCATE=false

# --- Internal Paths ---
INT_PYTHON="/opt/conda/bin/python3"
INT_AF_SCRIPT="/opt/alphafold/run_alphafold.py"

# --- Binary Tool Paths ---
BINARY_FLAGS=(
    "--hhblits_binary_path=/opt/conda/bin/hhblits"
    "--hhsearch_binary_path=/opt/conda/bin/hhsearch"
    "--jackhmmer_binary_path=/usr/bin/jackhmmer"
    "--kalign_binary_path=/usr/bin/kalign"
)

# --- Argument Parsing ---
IS_MULTIMER=false
DB_PRESET="full_dbs"

for arg in "$@"; do
  if [[ $arg == *"--model_preset=multimer"* ]]; then
    IS_MULTIMER=true
  fi
  if [[ $arg == *"--db_preset=reduced_dbs"* ]]; then
    DB_PRESET="reduced_dbs"
  fi
done

# --- Base Database Flags ---
DB_FLAGS=(
    "--data_dir=/data/data/2.3.2"
    "--uniref90_database_path=/data/uniref90/uniref90.fasta"
    "--mgnify_database_path=/data/mgnify/mgy_clusters_2022_05.fa"
    "--template_mmcif_dir=/data/pdb_mmcif/mmcif_files"
    "--obsolete_pdbs_path=/data/pdb_mmcif/obsolete.dat"
)

# --- Add Mode-Specific Flags ---
if [ "$IS_MULTIMER" = true ]; then
    # Multimer Mode: Add UniProt and SeqRes
    DB_FLAGS+=(
        "--uniprot_database_path=/data/uniprot/uniprot.fasta"
        "--pdb_seqres_database_path=/data/pdb_seqres/pdb_seqres.txt"
    )
else
    # Monomer Mode: Add PDB70
    DB_FLAGS+=("--pdb70_database_path=/data/pdb70/pdb70")
fi

# --- Add BFD / Small_BFD based on preset ---
if [[ $DB_PRESET == "reduced_dbs" ]]; then
    DB_FLAGS+=("--small_bfd_database_path=/data/small_bfd/bfd-first_non_consensus_sequences.fasta")
else
    DB_FLAGS+=(
        "--bfd_database_path=/data/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt"
        "--uniref30_database_path=/data/uniref30/UniRef30_2021_03"
    )
fi

# --- Execution ---
apptainer exec --nv --bind ${HOST_DATA_DIR}:/data ${SIF_FILE} \
    ${INT_PYTHON} ${INT_AF_SCRIPT} \
    "${BINARY_FLAGS[@]}" \
    "${DB_FLAGS[@]}" \
    "$@"
