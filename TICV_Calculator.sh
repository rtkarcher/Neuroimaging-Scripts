#!/bin/bash
# ======================================================
####      Total Intracranial Volume Calculator      ####
# ======================================================
#
# Polls all files with the suffix "_seg8.txt" within the working directory and calculates total intracranial volume (TICV) of all subjects' scans within a single output file ("All_TICV_Values.txt")
#
## Single-line command equivalents:
#### $ for i in *_seg8.txt; do segticv="TICV_"$i; seginfo=$(cat $i); ticv=$(awk '{print $1+$2+$3}' $i); printf "$seginfo$ticv" >> $segticv; done;
#### $ touch All_TICV_Values.txt && printf "  GMV  |  WMV  |  CSFV |  TICV\n\n" >> All_TICV_Values.txt
#### $ for f in TICV_*; do segfile=${f:6:${#f}-22}; ticvinfo=$(cat $f); printf "$segfile\n$ticvinfo\n" >> All_TICV_Values.txt; done
#
#
for i in *_seg8.txt
do 
	segticv="TICV_"$i; 
	seginfo=$(cat $i); 
	ticv=$(awk '{print $1+$2+$3}' $i); 
	printf "$seginfo$ticv" >> $segticv; 
done;

touch All_TICV_Values.txt
printf "  GMV  |  WMV  |  CSFV |  TICV\n\n" >> All_TICV_Values.txt;

for f in TICV_*
do
	segfile=${f:6:${#f}-22};
	ticvinfo=$(cat $f);
	outfile=All_TICV_Values.txt;
	printf "$segfile\n$ticvinfo\n\n" >> $outfile;
done;
rm TICV_*;
open All_TICV_Values.txt;
#
#
#
# for i in *_seg8.txt							# Looks into all files with suffix "_seg8.txt" within your working directory
# do 											#
#	segticv="TICV_"$i; 							# Sets new "TICV_" prefix for temporary files to be generated
#	seginfo=$(cat $i); 							# Refers to current contents of each "*_seg8.txt" file
#	ticv=$(awk '{print $1+$2+$3}' $i); 			# Calculates TICV value by adding the three existing values (GMV WMV CSFV) in the file
#	printf "$seginfo$ticv" >> $segticv; 		# Prints current contents (GMV WMV CSFV) of each "*_seg8.txt" file followed by the newly-calculated TICV value into a temporary "TICV_*_seg8.txt" file
# done
#
# for f in TICV_*												# Looks into all files with prefix "TICV_" within your working directory
# do															#
#	segfile=${f:6:${#f}-22};									# Shortens the existing filename, e.g., "TICV_p11883_038_02_MPRAGE_seg8.txt", to something like "11883_038_02"
#	ticvinfo=$(cat $f);											# Refers to current contents of each "TICV_*_seg8.txt" file
#	printf "$segfile\n$ticvinfo\n" >> All_TICV_Values.txt;		# Prints shortened filename of scan (e.g., "TICV_p11969_053_03_MPRAGE_seg8.txt" --> "11969_053_03") followed by 
#	rm TICV_*;													#    the scan's GMV, WMV, CSFV, and TICV values on the next line; repeats for each "TICV_*_seg8.txt" file present in working directory.
# done															# "rm TICV_*" simply cleans up the leftover "TICV_*_seg8.txt" files
#
#
#
