#!/bin/bash


# Clean past jobs

rm 02_snps/datarmor_jobs/GATK_*sh


# launch scripts
for file in $(ls 04_mapped/*.concordant_uniq|perl -pe 's/.concordant_uniq//'|sort -u)

do

base=$(basename "$file")

        toEval="cat 02_snps/02_gatk_prepare_bam.pbs | sed 's/__BASE__/$base/g'"; eval $toEval > 02_snps/datarmor_jobs/GATK_$base.sh
done

#Submit jobs
for i in $(ls 02_snps/datarmor_jobs/GATK_*sh); do qsub $i; done

