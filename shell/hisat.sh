#$ -S /bin/bash
#$ -pe def_slot 8
#$ -cwd
#$ -t 1-6:1
#$ -l mem_req=8G,s_vmem=8G
#$ -l debug

echo ${SGE_TASK_ID}

no=`expr ${SGE_TASK_ID} - 1`
ACCESSIONS=(`seq 453566 453571`)

echo $no
echo ${ACCESSIONS[${no}]}


QUERY1=../read/SRR${ACCESSIONS[${no}]}_1.fastq
QUERY2=../read/SRR${ACCESSIONS[${no}]}_2.fastq

REFERENCE=../reference/hisat/s288c.fna
GFF=../reference/s288c.gff

PREFIX=SRR${ACCESSIONS[${no}]}

echo $QUERY1
echo $QUERY2
echo ${no}

cd hisat
/usr/local/pkg/hisat2/2.1.0/hisat2 -p $NSLOTS -x $REFERENCE -1 $QUERY1 -2 $QUERY2 -S ${PREFIX}.sam --un ${PREFIX}.sam.unpaired.unmap.fastq --un-conc ${PREFIX}.sam.unmap.fastq --al ${PREFIX}.sam.unpaired.map.fastq --al-conc  ${PREFIX}.sam.map.fastq

/usr/local/pkg/samtools/current/bin/samtools view -@ $NSLOTS -b ${PREFIX}.sam > ${PREFIX}.bam
/usr/local/pkg/samtools/current/bin/samtools sort -@ $NSLOTS ${PREFIX}.bam > ${PREFIX}.sorted.bam
/usr/local/pkg/samtools/current/bin/samtools index -@ $NSLOTS ${PREFIX}.sorted.bam

rm ${PREFIX}.sam

cd ../featurecount

