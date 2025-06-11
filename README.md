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


## installing nextflow
The simplest way to install nextflow is with conda (or mamba). In our SLURM scripts, our environment is named *nfcore-rnaseq*, and you can create such a conda environment as follows:
```bash
mamba create -n nfcore-rnaseq -c conda-forge -c bioconda nextflow
```

In principle, you can call it anything, and might want to make it more generic, i.e. "nextflow" but be sure to fix the scripts before running! A nextflow workflow is typically called, as in our scripts, like this:

```bash
nextflow run nf-core/rnaseq  
```

From this command, nextflow knows to download the workflow from the remote, including all relevant dependencies. And the, voila, it runs!

## nf-core sample sheet
nfcore_samplesheet.csv is an example sample sheet, formatted specifically for the workflow. It's columns are described by theader:

```bash
sample,fastq_1,fastq_2,strandedness
```
where the sample column is for the unique sample name, fastq_1 and fastq_2 are paths to the R1 and R2 fastq files and strandedness indicates the strandedness of the library. We always set the value of strandedness to "auto" so salmon will auto-detect the strandedness configuration. It should also be noted that if the same sample name is found in more than one row, the count matrix will aggregate across those rows, i.e. if they were different runs on different lanes of a sequencer.


## input files
The current options in the SLURM scripts are run with gtf format annotation files. For custom references, if one wishes to use gff, one can switch the --gff command line switch to "--gff". Note that the suffix has to be "gff", it cannot be "gff3" otherwise the regular expression query on the input file hard-coded in nf-core will cause the job to fail. Also note that, because the workflow converts from gff to gtf internally, there is the potential for the loss of attribute information to lead to other errors. In other words, use gtf if possible. Also, the genome fasta needs to be gzipped and have ".gz" as the file extension. Finally, we provide a config file, *rnaseq_cannon.config*, that all of the scripts call on the command line,  that specifies partitions and resources for various steps. If you are trying to use this script on a cluster other that the Harvard cannon cluster, you will need to tweak partition names accordingly.

## working with UMI libraries
The Bauer Core builds UMI-basd bulk RNA-seq libraries with the SMRT-seq kit. If you are running on this sort of data, the following command line arguments will have to be added to the SLURM script:

```bash
--with_umi \
--umitools_extract_method "string" \
--umitools_bc_pattern 'NNNNNNNN' \
```
