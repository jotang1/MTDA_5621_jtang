#!/bin/bash
set -eE

database_dir="/fs/scratch/PZS1152/MTDA5621/databases"
database_paths=(
    "--data_dir=$database_dir/data/2.3.2"
    "--mgnify_database_path=$database_dir/mgnify/mgy_clusters_2022_05.fa"
    "--obsolete_pdbs_path=$database_dir/pdb_mmcif/obsolete.dat"
    "--template_mmcif_dir=$database_dir/pdb_mmcif/mmcif_files"
    "--uniref90_database_path=$database_dir/uniref90/uniref90.fasta"
)

# Default preset
model_preset_option="--model_preset=monomer"
db_preset_option="--db_preset=full_dbs"

# Command-line options
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    --model_preset=*)
    model_preset_option="$1"
    shift
    ;;
    --db_preset=*)
    db_preset_option="$1"
    shift
    ;;
    *)
    args+=("$1")
    shift
    ;;
esac
done

if [[ $db_preset_option == *"reduced_dbs" ]]; then
    database_paths+=(
        "--small_bfd_database_path=$database_dir/small_bfd/bfd-first_non_consensus_sequences.fasta"         
    )
else
    database_paths+=(
        "--bfd_database_path=$database_dir/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt"
        "--uniref30_database_path=$database_dir/uniref30/UniRef30_2021_03"
    )
fi 

if [[ $model_preset_option == *"multimer" ]]; then
   database_paths+=(
       "--pdb_seqres_database_path=$database_dir/pdb_seqres/pdb_seqres.txt"
       "--uniprot_database_path=$database_dir/uniprot/uniprot.fasta"
   )
else
    database_paths+=(
        "--pdb70_database_path=$database_dir/pdb70/pdb70"
    )
fi

echo Model: ${model_preset_option/*=/}
echo Database paths: 
for x in ${database_paths[@]}; do
  echo -e "  ${x}"
done

# For 2.2.2, disable using unified memory
# https://github.com/deepmind/alphafold/issues/406
export TF_FORCE_UNIFIED_MEMORY=${TF_FORCE_UNIFIED_MEMORY:-0}
export XLA_PYTHON_CLIENT_MEM_FRACTION=${XLA_PYTHON_CLIENT_MEM_FRACTION:-4.0}
singularity exec --nv /apps/alphafold/2.3.2/alphafold.sif python /app/alphafold/run_alphafold.py \
       	${database_paths[@]} \
        ${binary_paths[@]} \
        $model_preset_option \
	$db_preset_option "${args[@]}"
