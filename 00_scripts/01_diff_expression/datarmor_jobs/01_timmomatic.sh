for file in $(ls 02_data/*fastq.gz|perl -pe 's/_R[12].f(ast)?q.gz//'|sort -u)

do
        base=$(basename "$file")
        toEval="cat 01_diff_expression/01_trimmomatic_pe.pbs | sed 's/__BASE__/$base/g'"; eval $toEval > 01_diff_expression/datarmor_jobs/TRIM_"$base".sh
done


#change jobs header

#Submit jobs
for i in $(ls 01_diff_expression/datarmor_jobs/TRIM*sh); do qsub $i; done
