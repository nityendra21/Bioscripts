#!/bin/bash

# Author: Nityendra Shukla
# Contact: nityendras21@gmail.com
# Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

######### Script to download the assembled genome of an SRA sample through BioSample ID ############## 
## Currently doesn't work and further improvements needed, please feel free to add to it.

[[ "$#" -eq 2 ]] && destdir=$2 || destdir=$PWD

if test -z "$1" 
then
	echo "Error: input srr id list with comma delimited"
	exit 1
fi

srainput=$1
srainput=(${srainput//,/ })
#Retrieve Genbank accession from BioSample ID
IFS=$'\n'; 
for list in ${srainput[@]} 
do esearch -db nucleotide -query $list | efetch -db nucleotide -format acc >> gbk_list.txt; 
done

#Retrieve FASTA file from Genbank ID
for fetch in $(cat gbk_list.txt); 
do efetch -db protein -format fasta -id $fetch >> fetch.fa; 
done

#Split downloaded multifasta file acc to each accession:
cat *.fa | awk '/^>/ {if(N>0) printf("\n"); printf("%s\n",$0);++N;next;} { printf("%s",$0);} END {printf("\n");}' | split -l 2 - ID

for file in ID*
do 
 mv "$file" "$file.fa"
done

for i in *.fa
do 
 mv $i $(head -1 $i | cut -f1 -d ' ' | tr -d '>').fa
done
