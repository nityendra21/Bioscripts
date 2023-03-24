#!/bin/bash

## Concatenate all lanes in of a sequencing sample (single-end)
for name in *.fastq.gz
do 
printf '%s\n' "${name%_*_*_R[1]*}"
#for paired - print '%s\n' "${name%_*_*_R[12]*}"
done | uniq | 
while read prefix
do 
    cat "$prefix"*R1*.fastq.gz >"${prefix}_R1.fastq.gz"
#    cat "$prefix"*R2*.fastq.gz >"${prefix}_R2.fastq.gz" #paired-end
done
