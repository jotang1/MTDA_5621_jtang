Repo created for MTDA5621-AU25-Group G project by Joseph Tang.

## Project structure
```bash
.
├── AF_full_run.py
├── AF_full_slurm.sh
├── AF_msa_run.py
├── AF_structure_SI2025.sh
├── fastas
│   ├── P00974.fasta
│   ├── P01308.fasta
│   ├── P0CG47.fasta
│   ├── P42212.fasta
│   └── P99999.fasta
├── fastas.py
├── msas
│   ├── P00974
│   │   ├── features.pkl
│   │   ├── msas
│   │   │   ├── mgnify_hits.sto
│   │   │   ├── pdb_hits.hhr
│   │   │   ├── small_bfd_hits.sto
│   │   │   └── uniref90_hits.sto
│   │   ├── ranked_0.pdb
│   │   ├── ranked_1.pdb
│   │   ├── ranked_2.pdb
│   │   ├── ranked_3.pdb
│   │   ├── ranked_4.pdb
│   │   ├── ranking_debug.json
│   │   ├── relaxed_model_3_ptm_pred_0.pdb
│   │   ├── relax_metrics.json
│   │   ├── result_model_1_ptm_pred_0.pkl
│   │   ├── result_model_2_ptm_pred_0.pkl
│   │   ├── result_model_3_ptm_pred_0.pkl
│   │   ├── result_model_4_ptm_pred_0.pkl
│   │   ├── result_model_5_ptm_pred_0.pkl
│   │   ├── timings.json
│   │   ├── unrelaxed_model_1_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_2_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_3_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_4_ptm_pred_0.pdb
│   │   └── unrelaxed_model_5_ptm_pred_0.pdb
│   ├── P01308
│   │   ├── features.pkl
│   │   ├── msas
│   │   │   ├── mgnify_hits.sto
│   │   │   ├── pdb_hits.hhr
│   │   │   ├── small_bfd_hits.sto
│   │   │   └── uniref90_hits.sto
│   │   ├── ranked_0.pdb
│   │   ├── ranked_1.pdb
│   │   ├── ranked_2.pdb
│   │   ├── ranked_3.pdb
│   │   ├── ranked_4.pdb
│   │   ├── ranking_debug.json
│   │   ├── relaxed_model_1_ptm_pred_0.pdb
│   │   ├── relax_metrics.json
│   │   ├── result_model_1_ptm_pred_0.pkl
│   │   ├── result_model_2_ptm_pred_0.pkl
│   │   ├── result_model_3_ptm_pred_0.pkl
│   │   ├── result_model_4_ptm_pred_0.pkl
│   │   ├── result_model_5_ptm_pred_0.pkl
│   │   ├── timings.json
│   │   ├── unrelaxed_model_1_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_2_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_3_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_4_ptm_pred_0.pdb
│   │   └── unrelaxed_model_5_ptm_pred_0.pdb
│   ├── P0CG47
│   │   ├── features.pkl
│   │   ├── msas
│   │   │   ├── mgnify_hits.sto
│   │   │   ├── pdb_hits.hhr
│   │   │   ├── small_bfd_hits.sto
│   │   │   └── uniref90_hits.sto
│   │   ├── ranked_0.pdb
│   │   ├── ranked_1.pdb
│   │   ├── ranked_2.pdb
│   │   ├── ranked_3.pdb
│   │   ├── ranked_4.pdb
│   │   ├── ranking_debug.json
│   │   ├── relaxed_model_3_ptm_pred_0.pdb
│   │   ├── relax_metrics.json
│   │   ├── result_model_1_ptm_pred_0.pkl
│   │   ├── result_model_2_ptm_pred_0.pkl
│   │   ├── result_model_3_ptm_pred_0.pkl
│   │   ├── result_model_4_ptm_pred_0.pkl
│   │   ├── result_model_5_ptm_pred_0.pkl
│   │   ├── timings.json
│   │   ├── unrelaxed_model_1_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_2_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_3_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_4_ptm_pred_0.pdb
│   │   └── unrelaxed_model_5_ptm_pred_0.pdb
│   ├── P42212
│   │   ├── features.out
│   │   ├── features.pkl
│   │   ├── msas
│   │   │   ├── mgnify_hits.sto
│   │   │   ├── pdb_hits.hhr
│   │   │   ├── small_bfd_hits.sto
│   │   │   └── uniref90_hits.sto
│   │   ├── output
│   │   ├── ranked_0.pdb
│   │   ├── ranked_1.pdb
│   │   ├── ranked_2.pdb
│   │   ├── ranked_3.pdb
│   │   ├── ranked_4.pdb
│   │   ├── ranking_debug.json
│   │   ├── relaxed_model_2_ptm_pred_0.pdb
│   │   ├── relax_metrics.json
│   │   ├── result_model_1_ptm_pred_0.pkl
│   │   ├── result_model_2_ptm_pred_0.pkl
│   │   ├── result_model_3_ptm_pred_0.pkl
│   │   ├── result_model_4_ptm_pred_0.pkl
│   │   ├── result_model_5_ptm_pred_0.pkl
│   │   ├── timings.json
│   │   ├── unrelaxed_model_1_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_2_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_3_ptm_pred_0.pdb
│   │   ├── unrelaxed_model_4_ptm_pred_0.pdb
│   │   └── unrelaxed_model_5_ptm_pred_0.pdb
│   └── P99999
│       ├── features.pkl
│       ├── msas
│       │   ├── mgnify_hits.sto
│       │   ├── pdb_hits.hhr
│       │   ├── small_bfd_hits.sto
│       │   └── uniref90_hits.sto
│       ├── ranked_0.pdb
│       ├── ranked_1.pdb
│       ├── ranked_2.pdb
│       ├── ranked_3.pdb
│       ├── ranked_4.pdb
│       ├── ranking_debug.json
│       ├── relaxed_model_5_ptm_pred_0.pdb
│       ├── relax_metrics.json
│       ├── result_model_1_ptm_pred_0.pkl
│       ├── result_model_2_ptm_pred_0.pkl
│       ├── result_model_3_ptm_pred_0.pkl
│       ├── result_model_4_ptm_pred_0.pkl
│       ├── result_model_5_ptm_pred_0.pkl
│       ├── timings.json
│       ├── unrelaxed_model_1_ptm_pred_0.pdb
│       ├── unrelaxed_model_2_ptm_pred_0.pdb
│       ├── unrelaxed_model_3_ptm_pred_0.pdb
│       ├── unrelaxed_model_4_ptm_pred_0.pdb
│       └── unrelaxed_model_5_ptm_pred_0.pdb
├── PDB_Bfactor_plot.py
├── pLDDT_PAE_plot.py
├── pLDDT_PAE_plots
│   ├── P00974_result_model_3_ptm_pred_0_PAE.png
│   ├── P00974_result_model_3_ptm_pred_0_pLDDT.png
│   ├── P01308_result_model_1_ptm_pred_0_PAE.png
│   ├── P01308_result_model_1_ptm_pred_0_pLDDT.png
│   ├── P0CG47_result_model_3_ptm_pred_0_PAE.png
│   ├── P0CG47_result_model_3_ptm_pred_0_pLDDT.png
│   ├── P42212_result_model_2_ptm_pred_0_PAE.png
│   ├── P42212_result_model_2_ptm_pred_0_pLDDT.png
│   ├── P99999_result_model_5_ptm_pred_0_PAE.png
│   └── P99999_result_model_5_ptm_pred_0_pLDDT.png
└── run_alphafold.sh

13 directories, 145 files
```
