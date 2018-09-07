#$ -S /bin/bash
#$ -pe def_slot 1
#$ -cwd
#$ -l mem_req=3G,s_vmem=3G
#$ -l debug


REFERENCE=./reference/s288c.fna
GFF=./reference/s288c.gff

cd reference
mkdir hisat
/usr/local/pkg/hisat2/2.1.0/hisat2-build s288c.fna ./hisat/s288c.fna
cd /home/yanakamu/training/20181119
mkdir featurecount
mkdir hisat
