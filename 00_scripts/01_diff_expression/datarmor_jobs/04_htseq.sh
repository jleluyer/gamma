#!/bin/bash


# Clean past jobs

rm 01_diff_expression/datarmor_jobs/HTSQ_*sh

for i in $(ls 04_mapped/*sorted.bam|sed 's/.sorted.bam//g')

do
base="$(basename $i)"

        toEval="cat 01_diff_expression/04_htseq_count_genome.pbs| sed 's/__BASE__/$base/g'"; eval $toEval > 01_diff_expression/datarmor_jobs/HTSQ_$base.sh
done


#Submit jobs
for i in $(ls 01_diff_expression/datarmor_jobs/HTSQ*sh); do qsub $i; done

