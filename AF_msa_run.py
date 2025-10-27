#!/usr/bin/env python3

import subprocess
import sys

protein_id = sys.argv[1]

dir="{working_dir}"

command = f"""
{dir}/AF_msa_SI2025.sh \
  --fasta_paths={dir}/fastas/{protein_id}.fasta \
  --output_dir={dir}/msas/{output_dir} \
  --model_preset=monomer_ptm \
  --max_template_date=2023-01-01 \
  --db_preset=reduced_dbs \
  --use_gpu_relax=false \
  --only_generate_msas
"""
subprocess.run(command, shell=True)

