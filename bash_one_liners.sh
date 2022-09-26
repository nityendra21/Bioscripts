
# Author: Nityendra Shukla
# Contact: nityendras21@gmail.com
# Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

######### Simple bash commands to work with FASTA files ############

######### counting number of sequences in a fasta file: #########
grep -c "^>" file.fa

######### add something to end of all header lines: #########
sed 's/>.*/&WHATEVERYOUWANT/' file.fa > outfile.fa

######### clean up a fasta file so only first column of the header is outputted ##########
awk '{print $1}' file.fa > output.fa

########## To extract ids ############## 
grep -o -E "^>\w+" file.fasta | tr -d ">"

####### Remove duplicated sequences ########## 
sed -e '/^>/s/$/@/' -e 's/^>/#/' file.fasta | tr -d '\n' | tr "#" "\n" | tr "@" "\t" | sort -u -t $'\t' -f -k 2,2  | sed -e 's/^/>/' -e 's/\t/\n/'

######## Remove duplicated fastas in a multifasta ##########
seqkit rmdup -s <inputfile.fa> > <newfile.fa>
