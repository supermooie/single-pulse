# /usr/bin/python
import os
import sys

#This program is designed to plot all the graphs required by the module
#there are two major modes. One where the input is assumed to be a text file
#this is mainly used for plotting a folded profile. The other mode is used for
#plotting from a binary file (see documentation for a description of format).

# usage: infile, outfile, xstart, xend, <just_plot|ystart>, <yend>, <title>, <just_plot>
#note just_plot may be the 5th or 8th argument and should be the string "just_plot"
#just_plot means that the input file is a text file, otherwise a binary file is assumed
if len(sys.argv) < 2:
	sys.exit(0);

#get the command line arguments
in_file = sys.argv[1]; 
out_file = sys.argv[2];
xstart = sys.argv[3]; #start x zoom range
xend = sys.argv[4]; #end x zoom range
#just_plot may be the 5th argument or the 8th
just_plot = ((len(sys.argv) > 5) and (sys.argv[5] == "just_plot")) or ((len(sys.argv) > 8) and (sys.argv[8] == "just_plot"));

ystart = 0
yend = 0
if len(sys.argv) > 6:  #y axis zoom ranges
	ystart = sys.argv[5]
	yend = sys.argv[6]
if len(sys.argv) > 7: #get the legend
	title = sys.argv[7]

#if not just_plot convert from binary and select a fraction
#otherwise just plot the textfile
if not just_plot:
	plot_file = out_file+".plot";
	print in_file, plot_file, xstart, xend;
	bpstr = "./bp_fast %s %s %s %s 1000000" % (in_file, plot_file, xstart, xend);
	os.system(bpstr)
else:
	plot_file = in_file;

#pipe the plot description into gnuplot
fout = os.popen("gnuplot", "w");
if len(sys.argv) <= 7: #no legend set so dont use the default
	fout.write("set nokey\n");
fout.write("set xlabel \"Time (sec)\"\n");
fout.write("set ylabel \"Flux\"\n");
if ystart != 0 or yend != 0: #is there a y zoom mode needed?
	fout.write("set yrange["+ystart+":"+yend+"]\n");
fout.write("set term gif\n");
fout.write("set output \""+out_file+"\"\n");
range_str = ""
if xstart != "0" or xend != "0": #is there an x zoom mode needed?
	range_str = "[" + xstart + ":" + xend + "]";
if len(sys.argv) > 7: #use a legend
	fout.write("plot " + range_str + " \""+plot_file+"\" title \"" + title + "\" w l\n" );
else: #dont use a legend
	fout.write("plot " + range_str + " \""+plot_file+"\" w l" );
fout.close();
