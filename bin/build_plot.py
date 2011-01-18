#! /usr/bin/python
import os
import sys

# usage: infile, outfile, xstart, xend, just_plot
print "here3";
if len(sys.argv) < 2:
	sys.exit(0);

in_file = sys.argv[1];
out_file = sys.argv[2];
xstart = sys.argv[3];
xend = sys.argv[4];
just_plot = ((len(sys.argv) > 5) and (sys.argv[5] == "just_plot"));

ystart = 0
yend = 0
if len(sys.argv) > 6:
	ystart = sys.argv[5]
	yend = sys.argv[6]
print "here2";

#fout = open("GenImg/plot_tmp.gnu", "w");
#if ystart != 0 or yend != 0:
#	fout.write("set yrange["+ystart+":"+yend+"]\n");
#fout.write("set term gif\n");
#fout.write("set output \""+out_file+"\"\n");
#range_str = ""
#if xstart != "0" or xend != "0":
#	range_str = "[" + xstart + ":" + xend + "]";
#fout.write("plot " + range_str + " \""+in_file+"\" w l" );
#fout.close();
#os.system("gnuplot GenImg/plot_tmp.gnu");

if not just_plot:
	plot_file = out_file+".plot";

	print in_file, plot_file, xstart, xend;
	bpstr = "./bp_fast %s %s %s %s 10000" % (in_file, plot_file, xstart, xend);
	#print bpstr;
	#print os.popen(bpstr, "r").read();
	os.system(bpstr)
else:
	plot_file = in_file;

print "here";

fout = os.popen("gnuplot", "w");
fout.write("set nokey\n");
fout.write("set xlabel \"Time (sec)\"\n");
fout.write("set ylabel \"Flux\"\n");
if ystart != 0 or yend != 0:
	fout.write("set yrange["+ystart+":"+yend+"]\n");
fout.write("set term gif\n");
fout.write("set output \""+out_file+"\"\n");
range_str = ""
if xstart != "0" or xend != "0":
	range_str = "[" + xstart + ":" + xend + "]";
fout.write("plot " + range_str + " \""+plot_file+"\" w l" );
fout.close();
