#! /usr/local/bin/perl -w
use strict;
use warnings;
use Getopt::Long;

#################
#
#Date: May 11, 2015
#
#Author: Erin Osborne Nishimura
#
#Script purpose:  I typically have MACS2 output that I would like to threshold for peaks over a given score. Scores are located in the 
#
#INPUT: Input is
#                       a MACS2 _peaks.bed file that looks like this:
                    #chrI	11176	11732	MACS_peak_1	33.44
                    #chrI	36353	36729	MACS_peak_2	11.35
                    #chrI	38906	39187	MACS_peak_3	28.41
                    #chrI	116506	116931	MACS_peak_4	6.46
                    #chrI	122424	122775	MACS_peak_5	7.30
                    #chrI	128413	128920	MACS_peak_6	5.77
                    #chrI	167901	168157	MACS_peak_7	7.30
                    #chrI	256399	256603	MACS_peak_8	3.47
                    #chrI	310793	311034	MACS_peak_9	18.68
#                    
#                       a score for thresholding. If 5 is given, only entries with a score greater than 5 in the 5th columsn (-log10 score) will be captured.
#
#OUTPUT: Output is:     a _peaks_greaterN.bed
#
#USAGE:  perl threshold_macs2_peaks.pl --score <N> --list <file1.txt>
#        OR
#        perl threshold_macs2_peaks.pl --score <N> --bed <file1.bed,file2.bed>
#
#   
################

  
#Get the names of the options: annotation file and bamfiles
my $score = '';
my $list = '';
my $bed = '';

GetOptions ("score=i" => \$score,
            "list=s" => \$list,
            "bed=s" => \$bed)
or die("Error in command line arguments\n");

#print "score is $score\n";
#print "list is $list\n";
#print "bed is $bed\n";


if ($list) {
    
    #Check the list file is ok.
    unless (open (LIST, $list)){
        print "cannot open textfile that lists _peaks.bed files to process.\n";
        exit;
    }
    
    #Cycle through each entry of the list file and process each _peaks.bed file
    while (my $line = <LIST>){
        chomp $line;
        print $line, "\n";
        threshold(\$score, \$line);
        
        
    }

}

if ($bed){
    
    my @bedarray = split(",", $bed);

    foreach(@bedarray) {
        threshold(\$score, \$_);
    }
}





##############################################################################################
# SUBROUTINES
##############################################################################################
#A subroutine to capture only .bed entries with scores above the specified score threshold.
sub threshold {
    
    #capture referenced elements.
    my ($score_ref, $bed_ref) = @_;
    
    #Check for infile
    unless (open (BED, $$bed_ref)){
        print "cannot open bed file in bedlist\n";
        exit;
    }
    
    #Generate outfile
    my @bed_name_parse = split(".bed", $$bed_ref);
    my $outbed = $bed_name_parse[0] . "_greater" . $$score_ref . ".bed";
    
    unless (open(OUT, "> $outbed")){
        print"cannot open output file\n";
        exit;
    }
    
    #Print out what is happening:
    print "PROCESSING FILE:\n\tBed file to process:\t$$bed_ref\n\tMinimumScore:\t\t$$score_ref\n\tOutputfile:\t\t$outbed.\n";
    
    #Open the infile and go through each .bed entry:
    while (my $newline = <BED> ) {
        chomp $newline;
        #print $newline, "\n";
        
        #Split each line
        my @line_array = split("\t", $newline);
        
        #Check to see whether the score is greater than the user specified score; print if it is greater than or equal. Discard if it is not.
        if ($line_array[4] >= $$score_ref) {
            print OUT $newline, "\n";
        }
        
        
    }
    
    
}

#my $output = $time . "_HTseq_run.LOG";
#unless (open(OUT, ">$output")) {
#    print "cannot open output file\n";
#    exit;
#}

