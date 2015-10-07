#!/bin/bash
# ======================================================
####      Total Intracranial Volume Calculator      ####
# ======================================================
#
# Polls all files with the suffix "_seg8.txt" within the working directory and calculates total intracranial volume (TICV) of all subjects' scans within a single output file ("All_TICV_Values.txt")
#
#
output="All_TICV_Values.txt";
for i in *_seg8.txt
do
	segticv="TICV_"$i;
	seginfo=$(cat $i);
	ticv=$(awk '{print $1+$2+$3}' $i);
	printf "$seginfo$ticv" >> $segticv;
done;

printf "  GMV  |  WMV  |  CSFV |  TICV\n\n" >> $output;

for f in TICV_*
do
	segfile=${f:6:${#f}-22};
	ticvinfo=$(cat $f);
	printf "$segfile\n$ticvinfo\n\n" >> $output; 
done;

rm TICV_*;

if [ "$(uname)" == "Darwin" ]; then
	printf "\n\n     *            ..        *     *   \n  *     *       ......         *      \n            ..............            \n        ......................        \n*   ..............................    \n .................................... \n  ..................................  \n   ...... Calculating Volume ......   \n  ..................................  \n .................................... \n    ..............................    \n *      ......................      * \n    *       ..............     *      \n          *     ......      *     *   \n    *             ..           *      \n\n\n" && sleep 2 && open $output; 
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	printf "\n\n     *            ..        *     *   \n  *     *       ......         *      \n            ..............            \n        ......................        \n*   ..............................    \n .................................... \n  ..................................  \n   ...... Calculating Volume ......   \n  ..................................  \n .................................... \n    ..............................    \n *      ......................      * \n    *       ..............     *      \n          *     ......      *     *   \n    *             ..           *      \n\n\n" && sleep 2 && xdg-open $output; 
fi
#
#
# Line-by-line:
# ===============
#
# ln 9.   Sets aggregated output file name 
# ln 10.   Looks into all files with suffix "_seg8.txt" {$i} within your working directory
#
# ln 12   Sets new "TICV_" prefix for temporary files generated 
# ln 13.   Refers to current contents of each "*_seg8.txt" file
# ln 14    Calculates TICV value by adding the three existing values (GMV WMV CSFV) in the file
# ln 15.   Prints current contents (GMV WMV CSFV) of each "*_seg8.txt" file followed by the newly-calculated TICV value into a temporary "TICV_*_seg8.txt" file
#
# ln 18.   Adds value header labels to new aggregate output file
#
# ln 20.   Looks into all files with prefix "TICV_" {$f} within your working directory
#
# ln 22.   Truncates the existing filename (e.g., "TICV_p11111_123_02_MPRAGE_seg8.txt" --> "11111_123_02")
# ln 23.   Refers to current contents of each "TICV_*_seg8.txt" file
# ln 24.   Prints shortened filename of scan (e.g., "TICV_p11111_053_01_MPRAGE_seg8.txt" --> "11111_053_01") followed by all four values for GMV, WMV, CSFV, and TICV on the next line (followed by a line break) to the output file (titled "All_TICV_Values.txt" by default)
#
# ln 27.   Cleans up the leftover "TICV_*_seg8.txt" files
#
# ln 29.   Checks to see whether script is running on Linux/UNIX or Mac OS X, then opens the output file in the OS' default text editor
# ln 30.   Does something under Mac OS X platform
# ln 32.   Does something under Linux platform
