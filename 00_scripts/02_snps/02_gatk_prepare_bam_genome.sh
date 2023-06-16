#!/bin/bash
#PBS -N gatk.__BASE__
#PBS -o 98_log_files/prep.bam.__BASE__.err
#PBS -l walltime=03:00:00
#PBS -l mem=40g
#PBS -r n


cd $PBS_O_WORKDIR

REFERENCE="path_to_genome_folder/Pmarg.genome.masked.fa"
index="path_to_genome_folder/Pmarg.genome.masked.dict"
InDir="/home1/scratch/jleluyer/gamma/04_mapped"
OutDir="/home1/scratch/jleluyer/gamma/04_mapped/gatk"

GATK_jar="gatk-4.0.3.0/gatk-package-4.0.3.0-local.jar"
TmpDir="gamma/gatk"

base=__BASE__

# clean sam
java -Xmx35G -Djava.io.tmpdir="$TmpDir" -Dsamjdk.use_async_io_read_samtools=false -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Dsamjdk.compression_level=2 -jar "$GATK_jar" CleanSam \
	--INPUT "$InDir"/"$base".concordant_uniq \
	--OUTPUT "$OutDir"/"$base".clean.sam 2>&1 | tee 98_log_files/error."$base".log

