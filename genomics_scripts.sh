
# Author: Nityendra Shukla
# Contact: nityendras21@gmail.com
# Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.


################# changing fasta headers to 'reads1/1 format' ########################
bioawk -c fastx '{ print ">" $name "/1\n" $seq }' input.fa > newfile.fa

######### Moving files from multiple directories to a single directory ############# 
find /path to parent dir/ -name '*.ext' -exec cp -t /path to new dir/ {} +

####### Copying file with same extension from multiple directories to one directory before ###############
find /path/to/file/ -type f -name "*.fa" -execdir cp "{}" ../ \;


##################### bulk assembly using spades (or any other pipeline for that matter) ########################################################
for prefix in $(ls /path/*_1.fastq | sed -r 's/_1[.]fastq//' | uniq) 
do 
time metaspades.py -t 16 -1 ${prefix}_1.fastq -2 ${prefix}_2.fastq -o ${prefix%.fastq}_output 
done

################ bulk quast stats ###################
python ~/anaconda3/bin/metaquast.py $(find /path/tarvir_out/*_output/Contigs.fa) -t 16 -o ~/output/ -r reference.fa

########## bulk KAT comp ######################
for data in $(ls /home/username/path/*_1.fastq)
do 
kat comp -t 8 -o KAT_spades/${data%1.fastq}spades_KAT/ ${data} ${data%1.fastq}spades.fa
done

###### bash script to rename a final in each directory to the name of the folder ###########
##path to directory
for folder in path/to/dir/
do
#move to directory
 (cd "$folder")  
#Rename
  cp "$folder/contigs_k63.fa" "$folder.fa"
done

########## Using awk to parse unique vales of a particular column #############
awk '{print $2}' input_file | sort -u | wc -l 

##########check no. of mapped reads in sam file ######################
samtools view -c -F0x4 aln_complete.sam

##########check no. of unmapped reads in sam file ######################
samtools view -c -f0x4 aln_complete.sam

############### Filter primary reads in bam file ##################
samtools view -b -F 0x800 -F 0x100 output.bam > primary_alignment.bam

########### Seqkit locate to check mapping ##############
cat <referenceFasta> | seqkit locate -i -I -f <contigs.fa> -j <No. of threads>  > <Output_file.txt>

############ Seqkit stats to retrieve unique fasta headers ################3
Copy the <outputfile.txt> retrieved from seqkit locate 2nd column and and paste in <list.csv>.
seqkit grep -n -f list.csv <contigfile> > <output.fa> 
seqkit stats output.fa  

########## Using minimap2 for mapping to contig ###########
minimap2 -a [optional: -x choose platform] <fastafile> <contigfile> > mapped.sam

####### Remove secondary and supplementary alignments from bam file ##############3
samtools view -b -F 0x800 -F 0x100 mapped.bam > primary_alignment.bam

######## Preparing data for tablet visualisation #############
samtools view -Sb <fileName.out.sam> | samtools sort -m 4G -@ 8 -o <fileName.sorted.bam> - && $samtools index -@ 8 <fileName.sorted.bam>
