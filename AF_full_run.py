#!/usr/bin/env python3

import subprocess
import sys

protein_id = sys.argv[1]

dir="{working_directory}"

command = f"""
{dir}/AF_structure_SI2025.sh \
  --fasta_paths={dir}/fastas/{protein_id}.fasta \
  --output_dir={dir}/msas/{output_directory} \
  --model_preset=monomer_ptm \
  --max_template_date=2023-01-01 \
  --db_preset=reduced_dbs \
  --models_to_relax=best \
  --use_gpu_relax=true
"""
subprocess.run(command, shell=True)
