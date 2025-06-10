# nfcore_bulk_rnaseq
This repository briefly explains how to run the nf-core bulk-rnaseq nextflow workflow on Harvard's cannon cluster, in order to: 
* calculate a variety of QC metrics, and
* to produce gene and isoform-level count matrices

This workflow does sequence alignment with *STAR* and quantification using those alignments with *salmon*.

There are two ways to run the workflow:
* using pre-built references for one of the following reference genomes:
  * NCBI's *Mus musculus* genome and annotation, i.e. GRCm39
  * Ensembl's mouse genome and annotation for GRCm39
  * NCBI's human genome and annotation, i.e. GRCh38
  * Ensembl's genome and annotation for GRCh38

We also have available have STAR indices pre-built with nf-core for these references, which reduces run time. nf-core was built primarly around Ensembl annotations, but it usually works for NCBI annotations. For human and mouse, the code auto-detects particular issues with missing "biotypes" and does not try and generate metrics that rely on them. For NCBI genomes for other species, our workflow includes an additional switch, and the code also builds the STAR index (and saves it to the output). SLURM scripts for the four pre-built options above, as well as a "custom" reference are in the scripts directory.
