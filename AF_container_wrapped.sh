#!/bin/bash
set -e

# --- Configuration ---
SIF_FILE="/fs/scratch/PZS1154/alphafold/scripts/alphafold_2.3.2.sif"
HOST_DATA_DIR="/fs/scratch/PZS1154/alphafold/databases"

# --- HPC Performance Tuning ---
export TF_FORCE_UNIFIED_MEMORY=0
export XLA_PYTHON_CLIENT_MEM_FRACTION=4.0
export XLA_PYTHON_CLIENT_PREALLOCATE=false

# --- Internal Paths ---
INT_PYTHON="/opt/conda/bin/python3"
INT_AF_SCRIPT="/opt/alphafold/run_alphafold.py"

# --- Binary Tool Paths (Inside Container) ---
# Standard locations from alphafold_2.3.2.def
BINARY_FLAGS=(
    "--hhblits_binary_path=/usr/local/bin/hhblits"
    "--hhsearch_binary_path=/usr/local/bin/hhsearch"
    "--jackhmmer_binary_path=/usr/bin/jackhmmer"
    "--kalign_binary_path=/usr/bin/kalign"
)

# --- Parse db_preset for path mapping ---
DB_PRESET="full_dbs"
for arg in "$@"; do
  if [[ $arg == "--db_preset=reduced_dbs" ]]; then
    DB_PRESET="reduced_dbs"
  fi
done

# --- Build the Database Flags ---
DB_FLAGS=(
    "--data_dir=/data/data/2.3.2"
    "--uniref90_database_path=/data/uniref90/uniref90.fasta"
    "--mgnify_database_path=/data/mgnify/mgy_clusters_2022_05.fa"
    "--template_mmcif_dir=/data/pdb_mmcif/mmcif_files"
    "--obsolete_pdbs_path=/data/pdb_mmcif/obsolete.dat"
    "--pdb70_database_path=/data/pdb70/pdb70"
    "--uniprot_database_path=/data/uniprot/uniprot.fasta"
    "--pdb_seqres_database_path=/data/pdb_seqres/pdb_seqres.txt" 
)

if [[ $DB_PRESET == "reduced_dbs" ]]; then
    DB_FLAGS+=("--small_bfd_database_path=/data/small_bfd/bfd-first_non_consensus_sequences.fasta")
else
    DB_FLAGS+=("--bfd_database_path=/data/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt")
    DB_FLAGS+=("--uniref30_database_path=/data/uniref30/UniRef30_2021_03")
fi

# --- Execution ---
# "$@" passes everything else from AF_full_run.py (e.g., fasta_paths, output_dir, etc.)
apptainer exec --nv --bind ${HOST_DATA_DIR}:/data ${SIF_FILE} \
    ${INT_PYTHON} ${INT_AF_SCRIPT} \
    "${DB_FLAGS[@]}" \
    "$@"
