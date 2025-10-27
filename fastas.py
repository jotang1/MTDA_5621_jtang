#!/usr/bin/env python3

# Joseph Tang @ Ohio Supercomputer Center
# Extract protein sequence and write to an external file:
# ./fastas.py -i {/path/to/input/file} or -p {uniProt id} -o {path/to/output/directory}

from pathlib import Path
import argparse
import sys, re

UNIPROT_RE = re.compile(r"^([A-NR-Z][0-9]{5}|[OPQ][0-9][A-Z0-9]{3}[0-9]|[A-Z0-9]{10})$")

def validate_inputs(args):
    if args.input:
        fpath = Path(args.input)
        if not fpath.exists():
            sys.exit(f"Error: input file '{fpath}' not found.")
        if not fpath.is_file():
            sys.exit(f"Error: input file '{fpath}' is invalid.")
    
    elif args.id:
        if not UNIPROT_RE.match(args.id.strip()):
            sys.exit(f"Error: '{args.id}' is not a valid UniProt ID.")
    
    else:
        sys.exit("Error: must provide either --input (file) or --id (protein id).")

def extract_ids(target_ids, fastas_file, output_dir):
    count = 0
    total_targets = len(target_ids)

    write_flag = False
    current_id = None
    outfile = None

    with open(fastas_file, "r") as infile:
        for line in infile:
            if line.startswith(">"):
                # Check the completion:
                if count == total_targets:
                    break

                # Close previous output file
                if outfile:
                    outfile.close()
                    outfile = None

                parts = line.strip().split("|")
                if len(parts) >= 2:
                    current_id = parts[1].strip()
                    if current_id in target_ids:
                        out_path = Path(output_dir) / f"{current_id}.fasta"
                        outfile = open(out_path, "w")
                        write_flag = True
                        count +=1
                        print(f"Writing: ({count}/{total_targets}): {current_id}")

                    else:
                        write_flag = False

                else:
                    write_flag = False

            if write_flag and outfile:
                outfile.write(line)

    # Close final file if open
    if outfile:
        outfile.close()

    print("Script finished.")

def main():
    parser = argparse.ArgumentParser(description='Process atime YAML')
    parser.add_argument('-i', '--input', help = "file with UniProt IDs (one per line)")
    parser.add_argument('-p', '--id', type=str, help = "single uniProt id")
    parser.add_argument('-o', '--output', help = "output directory for FASTA files", required = True)
    parser.add_argument("-d", "--db", help="input FASTA database", default="uniprot_all_2021_04.fa")

    args = parser.parse_args()
    validate_inputs(args)

    Path(args.output).mkdir(parents=True, exist_ok=True)

    if args.input:
        with open(args.input, "r") as f: 
            target_ids = {line.strip() for line in f if line.strip()}        
    elif args.id:    
        target_ids = {args.id}
    else:
        parser.error("must provide either --input (file) or --id (single UniProt ID).")

    extract_ids(target_ids, args.db, args.output)    

if __name__ == "__main__":
    main()
