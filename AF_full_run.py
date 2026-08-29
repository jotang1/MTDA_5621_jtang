#!/usr/bin/env python3

import subprocess
import sys

protein_id = sys.argv[1]

dir="/path/to/working/dir"

command = f"""
{dir}/scripts/AF_container_wrapped.sh \
  --fasta_paths={dir}/AF2_fastas/{protein_id}.fasta \
  --output_dir={dir}/AF2_outputs \
  --model_preset=monomer_ptm \
  --max_template_date=2023-01-01 \
  --db_preset=reduced_dbs \
  --models_to_relax=best \
  --use_gpu_relax=true
"""
subprocess.run(command, shell=True)
