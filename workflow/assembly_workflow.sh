#!/bin/bash
# Spironucleus salmonicida Assembly Workflow

echo "=== Environment Setup ==="
conda create -n GenoDiplo flye -y
conda activate GenoDiplo

echo "=== Assembly ==="
flye --pacbio-raw ./ham_veri/SRR8895275.fastq \
  --genome-size 12.9m \
  --out-dir ./assembly \
  --threads 4

echo "=== Quality Analysis ==="
pip install quast
quast.py ./assembly/assembly.fasta -o ./quast_output
