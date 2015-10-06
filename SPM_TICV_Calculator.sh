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
for i in *_seg8.txt                                                    # Looks into all files with suffix "_seg8.txt" {$i} within your working directory
do 
	segticv="TICV_"$i;                                             # Sets new "TICV_" prefix for temporary files generated 
	seginfo=$(cat $i);                                             # Refers to current contents of each "*_seg8.txt" file
	ticv=$(awk '{print $1+$2+$3}' $i);                             # Calculates TICV value by adding the three existing values (GMV WMV CSFV) in the file
	printf "$seginfo$ticv" >> $segticv;                            # Prints current contents (GMV WMV CSFV) of each "*_seg8.txt" file followed by the newly-calculated TICV value into a temporary "TICV_*_seg8.txt" file
done;

printf "  GMV  |  WMV  |  CSFV |  TICV\n\n" >> All_TICV_Values.txt;    # Adds value header labels to new aggregate output file

for f in TICV_*                                                        # Looks into all files with prefix "TICV_" {$f} within your working directory
do
	segfile=${f:6:${#f}-22};                                       # Truncates the existing filename (e.g., "TICV_p11111_123_02_MPRAGE_seg8.txt" --> "11111_123_02")
	ticvinfo=$(cat $f);                                            # Refers to current contents of each "TICV_*_seg8.txt" file
	printf "$segfile\n$ticvinfo\n\n" >> All_TICV_Values.txt;       # Prints shortened filename of scan (e.g., "TICV_p11111_053_01_MPRAGE_seg8.txt" --> "11111_053_01") followed by 
done;                                                                  #   all four values for GMV, WMV, CSFV, and TICV on the next line (followed by a line break) to the aggregate
                                                                       #   output file titled "All_TICV_Values.txt"
rm TICV_*;                                                             # Cleans up the leftover "TICV_*_seg8.txt" files
if [ "$(uname)" == "Darwin" ]; then                                    # Checks to see whether script is running on Linux/UNIX or Mac OS X, then opens the All_TICV_Values.txt file in the OS' default text editor
    # Do something under Mac OS X platform
	open All_TICV_Values.txt;    
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under Linux platform
	xdg-open All_TICV_Values.txt;
  # elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under Windows NT platform
fi
#
#
