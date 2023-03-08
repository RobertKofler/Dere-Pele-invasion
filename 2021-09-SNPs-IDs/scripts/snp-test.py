#!/usr/bin/env python
import sys
import collections
import argparse
import copy
import math
import random
import re
## need hash

class SNP:
    def __init__(self,pos,sid,count):

        self.pos=pos
        self.sid=sid
        self.count=count
        
    def toString(self):
        #  pos  sid   cov
        cov=sum(self.count)
        pr="{0}\t{1}\t{2}\t{3}:{4}:{5}:{6}".format(self.pos,self.sid, cov, self.count[0],self.count[1],self.count[2],self.count[3])
        return pr
        

class DeviateSNPReader:
    
    @classmethod
    def readSNPFile(cls,inputfile,minfreq,mincount):
        toret=[]
        for line in open(inputfile):
            if line.startswith('#'):
                continue
            # 0     1         2     3    4 5 6 7 8      9       10     11   12  13
            #TEfam sample_id pos refbase A C G T cov phys_cov hq_cov snp refsnp int_del int_del_freq trunc_left trunc_right ins delet annotation
            # 0      1          2  3 4 5 6 7   8    9   10   11   12    13          14                      
            # PPI251 tmp.fastq 985 T 0 1 0 180 181 0.0 181 False False 985:2677:1 985:2677:0.04833111941573226 NA NA NA NA CDS

            # compute coverage
            a = line.rstrip('\n').split(' ')
            skey=a[1]
            rep,gen=None,None
            if("." in skey and "/" in skey):
                skey = a[1].split('/')[-1].split('.')[0] # SRR, careful!! confirmed for: NA and droseu gdl
                # ACAGTG_ere_R1G10

            aa,c,g,t=int(a[4]),int(a[5]),int(a[6]),int(a[7])
            alleles=[aa,c,g,t]
            cov=float(aa+c+g+t)
            freqs = [float(i)/cov for i in alleles]
            
            
            
            freqcount=0
            for f in freqs:
                if f >=minfreq:
                    freqcount+=1
            allelecount=0
            for al in alleles:
                if al >=mincount:
                    allelecount+=1
            if allelecount>=2 and freqcount>=2:    
                pos=int(a[2])
                # (self,chrm,pos,sid,count,freq):
                toret.append(SNP(pos,skey,[aa,c,g,t]))
        return toret
    




parser = argparse.ArgumentParser(description="""           
Description
-----------
    distance matrix for TEs""",formatter_class=argparse.RawDescriptionHelpFormatter,
epilog="""
Prerequisites
-------------
    python version 3+

Authors
-------
    Robert Kofler 
""")


parser.add_argument("--deviate", type=str, required=True, dest="deviate", default=None, help="A multi-DeviaTE file; ie concatenatio of many samples ")
parser.add_argument("--min-freq", type=float, required=False, dest="minf", default=0.0, help="minimum abundance of SNP in TE")
parser.add_argument("--min-count", type=float, required=False, dest="minc", default=0, help="minimum count of SNP in TE")
args = parser.parse_args()#
minfreq=float(args.minf)
mincount=int(args.minc)

## remove singletons



snps=DeviateSNPReader.readSNPFile(args.deviate,args.minf,args.minc)

for snp in snps:
    print(snp.toString())



