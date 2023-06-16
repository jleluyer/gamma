# GAMMA: Gene expression plasticity, genetic variation and fatty acid remodelling in divergent populations of a tropical bivalve species

An integrated worklow based on genome-mapping and DE gene assessment to conduct RNA-seq data analyses on cluster machines


**WARNING**

The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.


## Documentation

### Part 1. RNAseq Expression analysis:


For this section, you will need to modify the cluster parameters and the $WORKDIR variable as well as the path to all sofwares according to your own specificities.


#### 1. Trimming:

We used Trimmomaticv0.36
For this, run:

```shell
./00_scripts/01_diff_expression/datarmor_jobs/01_trimmomatic.sh
```


#### 2. Genome indexing:

We used GSNAP (GMAPv2021.08.25)
For this, run:

```shell
qsub 00_scripts/01_diff_expression/02_gmap_index_genome.pbs
```


#### 3. Mapping:

We used GMAPv2021.08.25

For this, run:

```shell
./00_scripts/01_diff_expression/datarmor_jobs/03_mapping.sh
```

#### 4. Counting:

We used hstseqv0.9.1

For this, run:

```shell
./00_scripts/01_diff_expression/datarmor_jobs/04_htseq.sh
```

### Part 2. SNP analysis:

For this section we followed GATK best practices for SNPs identification from RNAseq data. Please see: https://gatk.broadinstitute.org/hc/en-us/articles/360035531192-RNAseq-short-variant-discovery-SNPs-Indels-

#### 1. Prepare genome reference:

We used GATK4.0.3.0

For this, run:

```shell
qsub 00_scripts/02_snps/01_gatk_prepare_ref.pbs
```

#### 2. Cleaning BAM files:

```shell
./00_scripts/02_snps/daarmor_jobs/02_gatk_prepare_bam.pbs
```

```shell
./00_scripts/02_snps/daarmor_jobs/03_dedup_bam.pbs
```

#### 3. Calling and combining variants:

```shell
./00_scripts/02_snps/datarmor_jobs/04_Haplotypecaller.pbs
```

```shell
qsub 00_scripts/02_snps/datarmor_jobs/05_combine_gvcf.sh
```

#### 4. Variant filtration and imputation:

We used VCFtoolsv0.1.16 and Beaglev4.0_06Jun17, respectively

We used for filtration following thresholds:
* Keep only SNPs pattern (without complex events)
* A minimum depth (DP) of 10 reads per locus per genotype within an individual (under that, the genotype is transformed to "NA").
* A minor allele frequency (MAF) of at least 10% in the sampleset
* Less than 10% missing data (miss) at a locus (over that, the locus is removed)
* Only loci that are biallelic
 

```shell
qsub 00_scripts/02_snps/06_variant_filtering.pbs
```
 
 ```shell
qsub 00_scripts/02_snps/04_combine_gvcf.pbs
```
 
### Part 3. Downstream analysis:

We provided all the scripts necessary to explore further the data (Differential expression, co-expression network analysis, Outlier SNPs, Plasticity quantification)


```shell
00_scripts/03_downstream_analysis/
```
