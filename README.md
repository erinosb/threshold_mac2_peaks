# threshold_mac2_peaks
I typically like to run MACS2 with a default score of 0.01 or 0.005. This gives me a long list of peaks. I often like to capture just the most confident peaks, for example, those that are over -log10 score of 5 or 10.

####Date
May 11, 2015

####Author
Erin Osborne Nishimura

####Script purpose
I typically have MACS2 output that I would like to threshold for peaks over a given score. 

####INPUT
Input is EITHER a LIST file containing the name of a bed file on each line
                   OR a comma-separated list of .bed files.

                   LIST:
                        #9_EO038_over_EO042_0.005_peaks.bed
                        #9_EO039_over_EO042_0.005_peaks.bed

                   Each entry in the list must contain an MACS2 peaks_bed file that looks like this when opened:
                        #chrI	11176	11732	MACS_peak_1	2.44
                        #chrI	36353	36729	MACS_peak_2	11.35
                        #chrI	38906	39187	MACS_peak_3	28.41
                        #chrI	116506	116931	MACS_peak_4	3.46
                        #chrI	122424	122775	MACS_peak_5	7.30
                        #chrI	128413	128920	MACS_peak_6	5.77
                        #chrI	167901	168157	MACS_peak_7	7.30
                        #chrI	256399	256603	MACS_peak_8	3.47
                        #chrI	310793	311034	MACS_peak_9	18.68
                    
                   SCORE:
                       A numeric score for thresholding.
                       If 5 is given, only entries with a score greater than 5 in the 5th columsn (-log10 score) will be captured.

###OUTPUT
Output is:     a file1_peaks_greaterN.bed in which only the .bed entries with a score greater than the user specified score are retained:

                        #chrI	36353	36729	MACS_peak_2	11.35
                        #chrI	38906	39187	MACS_peak_3	28.41
                        #chrI	122424	122775	MACS_peak_5	7.30
                        #chrI	128413	128920	MACS_peak_6	5.77
                        #chrI	167901	168157	MACS_peak_7	7.30
                        #chrI	310793	311034	MACS_peak_9	18.68
                        
                        
####USAGE
*perl threshold_macs2_peaks.pl --score <N> --list <file1.txt>*

OR
       
*perl threshold_macs2_peaks.pl --score <N> --bed <file1.bed,file2.bed>*
