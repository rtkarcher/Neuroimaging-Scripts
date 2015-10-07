#!/bin/bash
# ======================================================
####      Total Intracranial Volume Calculator      ####
# ======================================================
#
# Polls all files with the suffix "_seg8.txt" within the working directory and calculates total intracranial volume (TICV) of all subjects' scans within a single output file ("All_TICV_Values.txt")
#
#
## Single-line command equivalents:
#
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

printf "  GMV  |  WMV  |  CSFV |  TICV\n\n" >> All_TICV_Values.txt;

for f in TICV_*
do
	segfile=${f:6:${#f}-22};
	ticvinfo=$(cat $f);
	printf "$segfile\n$ticvinfo\n\n" >> All_TICV_Values.txt;
done;

rm TICV_*;

if [ "$(uname)" == "Darwin" ]; then
	printf "\n\n     *            ..        *     *   \n  *     *       ......         *      \n            ..............            \n        ......................        \n*   ..............................    \n .................................... \n  ..................................  \n   ...... Calculating Volume ......   \n  ..................................  \n .................................... \n    ..............................    \n *      ......................      * \n    *       ..............     *      \n          *     ......      *     *   \n    *             ..           *      \n\n\n" && sleep 2 && open All_TICV_Values.txt;
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	printf "\n\n     *            ..        *     *   \n  *     *       ......         *      \n            ..............            \n        ......................        \n*   ..............................    \n .................................... \n  ..................................  \n   ...... Calculating Volume ......   \n  ..................................  \n .................................... \n    ..............................    \n *      ......................      * \n    *       ..............     *      \n          *     ......      *     *   \n    *             ..           *      \n\n\n" && sleep 2 && xdg-open All_TICV_Values.txt;
fi
#
#
# Line-by-line Structural Breakdown:
# ==================================
# 
# ln 14.  Looks into all files with suffix "_seg8.txt" {$i} within your working directory
#
# ln 16.  Sets new "TICV_" prefix for temporary files generated 
# ln 17.  Refers to current contents of each "*_seg8.txt" file
# ln 18.  Calculates TICV value by adding the three existing values (GMV WMV CSFV) in the file
# ln 19.  Prints current contents (GMV WMV CSFV) of each "*_seg8.txt" file followed by the newly-calculated TICV value into a temporary "TICV_*_seg8.txt" file
#
# ln 22.  Adds value header labels to new aggregate output file
#
# ln 24.  Looks into all files with prefix "TICV_" {$f} within your working directory
#
# ln 26.  Truncates the existing filename (e.g., "TICV_p11111_123_02_MPRAGE_seg8.txt" --> "11111_123_02")
# ln 27.  Refers to current contents of each "TICV_*_seg8.txt" file
# ln 28.  Prints shortened filename of scan (e.g., "TICV_p11111_053_01_MPRAGE_seg8.txt" --> "11111_053_01") followed by all four values for GMV, WMV, CSFV, and TICV on the next line (followed by a line break) to the aggregate output file titled "All_TICV_Values.txt"
#
# ln 31.  Cleans up the leftover "TICV_*_seg8.txt" files
#
# ln 33.  Checks to see whether script is running on Linux/UNIX or Mac OS X, then opens the All_TICV_Values.txt file in the OS' default text editor
# ln 34.  Does something under Mac OS X platform
# ln 36.  Does something under Linux platform
