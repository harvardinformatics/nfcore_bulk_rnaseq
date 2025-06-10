#!/bin/bash 
#SBATCH -J rnaslurm
#SBATCH -N 1
#SBATCH -c 1
#SBATCH -t 23:00:00                 # Runtime in D-HH:MM 
#SBATCH -p sapphire         # Partition to submit to 
#SBATCH --mem=12000              
#SBATCH -e nf-core_star_salmon_%A.err
#SBATCH -o nf-core_star_salmon_%A.out

module load python
mamba activate nfcore-rnaseq
gtf=$1
genome=$2
nextflow run nf-core/rnaseq \
    --input nfcore_samplesheet.csv \
    --outdir $(pwd)/star_salmon \
    --skip_biotype_qc \
    --gtf $gtf \
    --fasta $fasta \
    --aligner star_salmon \
    -profile singularity \
    --save_reference \
    -c rnaseq_cannon.config 
