#!/usr/bin/env python
import os
import sys
import inspect
import re
import argparse
import random
import math
import collections
import fileinput
import math


from syncIO import SyncReaderMajMin

        

def parse_line(entries,baselist,derivedlist):
        parsed=entries
        
        derivedentries=[]
        baseentries=[]
        for i in derivedlist:
                key=i-1
                derivedentries.append(parsed[key])
        
        for i in baselist:
                key=i-1
                baseentries.append(parsed[key])
        return (baseentries,derivedentries)


def av_freq(s):
	f=0.0
	for mac,mic in s:
		fr=float(mac)/(float(mac+mic))
		f+=fr
	return f/float(len(s))

def format_s(s):
	toparse=[]
	toparse.append("base "+format_sub(s[0:2]))# two
	toparse.append("R1 "+format_sub(s[2:8])) 
	toparse.append("R2 "+format_sub(s[8:14]))
	toparse.append("R4 "+format_sub(s[14:]))
	return "\t".join(toparse)
	


def format_sub(sub):
	toret=[]
	for e in sub:
		toret.append("{0}:{1}".format(int(e[0]),int(e[1])))
	return ",".join(toret)
		




parser = argparse.ArgumentParser(description="""           
Description
-----------
Summary statistics
""",formatter_class=argparse.RawDescriptionHelpFormatter,
epilog="""

Authors
-------
""")

parser.add_argument('--sync', type=argparse.FileType('r'), default=None,dest="sync", required=True, help="A sync file")
parser.add_argument('--min-cov', type=int,dest="mincov", required=True, help="The mincoverage file")
parser.add_argument('--min-dist', type=float,dest="mindist", required=True, help="The minimum distance")

args = parser.parse_args()
mincov=args.mincov
mindist=args.mindist

for chr,pos,mami,s in SyncReaderMajMin(args.sync):
	#				0		1				2			3			4			
	# contig_8 61632 ('A', 'T') [(13.0, 0.0), (5.0, 0.0), (16.0, 0.0), (22.0, 0.0), (23.0, 0.0), (6.0, 0.0), (20.0, 0.0), (16.0, 0.0), (23.0, 0.0), (16.0, 0.0), (15.0, 0.0), (27.0, 0.0), (13.0, 0.0), (20.0, 0.0), (20.0, 0.0), (17.0, 0.0), (17.0, 0.0), (12.0, 0.0), (13.0, 0.0), (13.0, 0.0)]
	ignore=False
	for mac,mic in s:
		if mac+mic<mincov:
			ignore =True
			break
			
	if ignore:
		continue
	
	snp=False
	for mac,mic in s:
		if mic>0:
			snp=True
			break
	if not snp:
		continue
	
	#withinbasedif=math.fabs(av_freq(s[0:1])-av_freq(s[1:2]))
	#if(withinbasedif>0.3):
	#	continue # exclude crap where estimates within the base do not agree
	base=s[0:2] # tww
	r1s=s[2:4] 
	r1e=s[6:8] 
	r2s=s[8:10]
	r2e=s[12:14]
	r4s=s[14:16]
	r4e=s[18:]
	
	bf,r1fs,r2fs,r4fs=av_freq(base),av_freq(r1s),av_freq(r2s),av_freq(r4s)
	r1fe,r2fe,r4fe=av_freq(r1e),av_freq(r2e),av_freq(r4e)
	d1,d2,d4=math.fabs(r1fs-r1fe),math.fabs(r2fs-r2fe),math.fabs(r4fs-r4fe)
	toparse=[(d1,"R1"),(d2,"R2"),(d4,"R4")]
	
	toprint=[str(chr),str(pos),"{0},{1}".format(mami[0],mami[1])]
	for d,rep in toparse:
		if d>=mindist:
			prd=list(toprint)
			prd.append(rep)
			prd.append(str(d))
			prd.append(format_s(s))
			print("\t".join(prd))
	
