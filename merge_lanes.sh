#!/bin/bash

## Concatenate all sequenced lanes of a sequencing sample (single-end), edit for paired-end. 
for file in *.fastq.gz
do 
printf '%s\n' "${file%_*_*_R[1]*}"
#for paired - print '%s\n' "${file%_*_*_R[12]*}"
done | uniq | 
while read fastq
do 
    cat "$fastq"*R1*.fastq.gz >"${fastq}_R1.fastq.gz"
#    cat "$fastq"*R2*.fastq.gz >"${fastq}_R2.fastq.gz" #paired-end
done
