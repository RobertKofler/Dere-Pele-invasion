#!/usr/bin/env python
import sys
import collections
import argparse
import copy
import math
import random
import re
## need hash


class DeviateSNPReader:
    
    @classmethod
    def readSNPFile(cls,inputfile):
        posh=collections.defaultdict(lambda:collections.defaultdict(lambda:collections.defaultdict(lambda:{"A":0,"C":0,"G":0,"T":0})))
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
                tmp=skey.split("_")[2]
                tmp=tmp.lstrip("R")
                rep,gen=tmp.split("G")
            aa,c,g,t=int(a[4]),int(a[5]),int(a[6]),int(a[7])
            toap={"A":aa,"C":c,"G":g,"T":t}
            pos=int(a[2])
            posh[rep][gen][pos]=toap
        return posh
    
def convert(snps):
    tot={"A":0.0,"C":0.0,"G":0.0,"T":0.0}
    for s in snps:
        cov=float(sum(s.values()))
        tot["A"]+=float(s["A"])/cov
        tot["C"]+=float(s["C"])/cov
        tot["T"]+=float(s["T"])/cov
        tot["G"]+=float(s["G"])/cov
    aso=sorted(tot.items(),key=lambda i:-i[1])
    ma,mi=aso[0][0],aso[1][0]
    toret=[]
    for s in snps:
        cov=float(s["A"]+s["T"]+s["C"]+s["G"])
        maf=float(s[ma])/cov
        mif=float(s[mi])/cov
        toret.append([cov,maf,mif])
    return(ma,mi,toret)


def checkIFSNP(snps,minfreq,mincount):
    #[{A:1,T:,}]
    for snp in snps:
        alleles=snp.values()
        cov=float(sum(alleles))
        freqs=[float(i)/cov for i in alleles]
        allelcount,freqcount=0,0
        for al in alleles:
            if al>=mincount:
                allelcount+=1
        for fr in freqs:
            if fr>=minfreq:
                freqcount+=1
        if freqcount>=2 and allelcount>=2:
            return True
    return False




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
parser.add_argument("--min-count", type=int, required=False, dest="minc", default=0, help="minimum abundance of SNP in TE")
args = parser.parse_args()#
minfreq=float(args.minf)
mincount=int(args.minc)

## remove singletons


posh=DeviateSNPReader.readSNPFile(args.deviate)


poshnew={}
for rep,tmp in posh.items():
    for pos in range(0,2907):
        tocheck=[]
        for gen in ["1","10","20","34","40","48"]:
            t=posh[rep][gen][pos]
            tocheck.append(t)

        issnp=checkIFSNP(tocheck,minfreq,mincount)
        ma,mi,snps=convert(tocheck)
        if issnp:
            tcs=[]
            for  cov,maf,mif in snps:
                tcs.append("{0}\t{1}".format(int(cov),mif))
            toprint=[str(rep),str(pos),ma,mi ,"\t".join(tcs)]
            print("\t".join(toprint))
        

