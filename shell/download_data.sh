#$ -S /bin/bash
#$ -pe def_slot 8
#$ -cwd
#$ -l mem_req=8G,s_vmem=8G
#$ -l debug

mkdir read
cd read

# Batch culture: SRX135198   SRR453566 - SRR453568
ACCESSIONS=`seq 453566 453568`
for NUM in $ACCESSIONS
do
	echo Retrieving SRA file for SRR${NUM}...
	wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/SRX/SRX135/SRX135198/SRR${NUM}/SRR${NUM}.sra
	echo Converting SRA to FASTA...
	fastq-dump --split-files SRR${NUM}.sra
done

# chemostat: SRX135710 SRR453569 - SRR453571
ACCESSIONS=`seq 453569 453571`
for NUM in $ACCESSIONS
do
	echo Retrieving SRA file for SRR${NUM}...
	wget ftp://ftp.ddbj.nig.ac.jp/ddbj_database/dra/sralite/ByExp/litesra/SRX/SRX135/SRX135710/SRR${NUM}/SRR${NUM}.sra
	echo Converting SRA to FASTA...
	fastq-dump --split-files SRR${NUM}.sra
done
rm SRR*.sra
cd ../


# リファレンスゲノム取得
# Saccharomyces cerevisiae S288C (baker's yeast)
# RefSeqのデータを利用
# https://www.ncbi.nlm.nih.gov/assembly/GCF_000146045.2

mkdir reference
cd reference

# Genomic FASTAファイル
wget ftp://ftp.ncbi.nlm.nih.gov//genomes/all/GCF/000/146/045/GCF_000146045.2_R64/GCF_000146045.2_R64_genomic.fna.gz
# GFFファイル
wget ftp://ftp.ncbi.nlm.nih.gov//genomes/all/GCF/000/146/045/GCF_000146045.2_R64/GCF_000146045.2_R64_genomic.gff.gz
gunzip *.gz


mv GCF_000146045.2_R64_genomic.gff s288c.gff
mv GCF_000146045.2_R64_genomic.fna s288c.fna

# Subread プログラムの取得
cd ..
mkdir tool
cd tool
wget wget https://sourceforge.net/projects/subread/files/subread-1.6.2/subread-1.6.2-Linux-x86_64.tar.gz
tar xvf subread-1.6.2-Linux-x86_64.tar.gz



