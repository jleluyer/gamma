#!/bin/bash


# Clean past jobs

rm 02_snps/datarmor_jobs/HAPLO_*sh


# launch scripts 
for file in $(ls 04_mapped/*.split.bam|perl -pe 's/.split.bam//'|sort -u)

do

base=$(basename "$file")

        toEval="cat 02_snps/04_Haplotypecaller.pbs | sed 's/__BASE__/$base/g'"; eval $toEval > 02_snps/datarmor_jobs/HAPLO_$base.sh
done

#Submit jobs
for i in $(ls 02_snps/datarmor_jobs/HAPLO_*sh); do qsub $i; done
