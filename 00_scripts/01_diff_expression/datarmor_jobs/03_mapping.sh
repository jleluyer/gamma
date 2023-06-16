#!/bin/bash


# Clean past jobs

rm 01_diff_expression/datarmor_jobs/GSNAP_*sh


# launch scripts for Colosse
for file in $(ls 03_trimmed/*paired*.f*q.gz|perl -pe 's/_R[12].paired.fastq.gz//'|sort -u)
do

base=$(basename "$file")

        toEval="cat 01_diff_expression/03_gsnap_mapping_genome.pbs | sed 's/__BASE__/$base/g'"; eval $toEval > 01_diff_expression/datarmor_jobs/GSNAP_$base.sh
done

#Submit jobs
for i in $(ls 01_diff_expression/datarmor_jobs/GSNAP_*sh); do qsub $i; done
