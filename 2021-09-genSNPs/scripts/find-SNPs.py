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
parser.add_argument('--min-count', type=int,dest="mincount", required=True, help="The min count for a SNP")

args = parser.parse_args()
mincov=args.mincov
mincount=args.mincount

for chr,pos,mami,s in SyncReaderMajMin(args.sync):
	# contig_8 61632 ('A', 'T') [(13.0, 0.0), (5.0, 0.0), (16.0, 0.0), (22.0, 0.0), (23.0, 0.0), (6.0, 0.0), (20.0, 0.0), (16.0, 0.0), (23.0, 0.0), (16.0, 0.0), (15.0, 0.0), (27.0, 0.0), (13.0, 0.0), (20.0, 0.0), (20.0, 0.0), (17.0, 0.0), (17.0, 0.0), (12.0, 0.0), (13.0, 0.0), (13.0, 0.0)]
	ignore=False
	for mac,mic in s:
		if mac+mic<mincov:
			ignore =True
			
	if ignore:
		continue
	
	snp=False
	for mac,mic in s:
		if mic>=mincount:
			snp =True
	if not snp:
		continue
	

		
	print chr,pos,mami,s