#$ -S /bin/bash
#$ -pe def_slot 8
#$ -cwd
#$ -l mem_req=8G,s_vmem=8G
#$ -l debug


GFF=../reference/s288c.gff

cd hisat
../tools/subread-1.6.2-Linux-x86_64/bin/featureCounts -p -T 8 -t exon -g gene -a $GFF -o ../featurecount/counts.txt SRR453566.sorted.bam SRR453567.sorted.bam SRR453568.sorted.bam SRR453569.sorted.bam SRR453570.sorted.bam SRR453571.sorted.bam


