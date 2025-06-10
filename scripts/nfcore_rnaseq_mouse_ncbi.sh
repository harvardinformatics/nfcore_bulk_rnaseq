#!/bin/bash 
#SBATCH -J rnaslurm
#SBATCH -N 1
#SBATCH -c 1
#SBATCH -t 12:00:00                 # Runtime in D-HH:MM 
#SBATCH -p sapphire         # Partition to submit to 
#SBATCH --mem=12000              
#SBATCH -e nf-core_star_salmon_%A.err
#SBATCH -o nf-core_star_salmon_%A.out

module load python
mamba activate nfcore-rnaseq

nextflow run nf-core/rnaseq \
    --input samplesheet.csv \
    --outdir $(pwd)/star_salmon \
    --gtf /n/inffs01/sops/refs/nf-core_bulk/GRCm39_ncbi/GCF_000001635.27_GRCm39_genomic.gtf \
    --fasta /n/inffs01/sops/refs/nf-core_bulk/GRCm39_ncbi/GCF_000001635.27_GRCm39_genomic.fna.gz \
    --aligner star_salmon \
    -profile singularity \
    --star_index /n/inffs01/sops/refs/nf-core_bulk/GRCm39_ncbi/STAR \
    -c rnaseq_cannon.config 
