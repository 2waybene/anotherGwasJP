import sys
import shlex
import subprocess as sp
import os

def common_variant_analysis_genotyped():
    #print 'Number of arguments', len(sys.argv), 'arguments.'
    #print 'Argument List:', str(sys.argv)
    print '\n************************************'        
    print '******* Begin JOB:',sys.argv[0]

    for path in sys.argv[1:]:
        print '*************************************'
        print 'Current working path:',path
        #print '*************************************'
        ## Read in phenotypes.txt and modeltypes.txt
        phenos = [line.strip() for line in open(path+'/phenotypes.txt', 'r')]
        models = [line.strip() for line in open(path+'/modeltypes.txt', 'r')]
        
        #print phenos
        #print models
        #print snplist

        ## For each phenotype/modeltype, launch common variant analysis
        for i,pheno in enumerate(phenos):
            ## modeltype is passed as a parameter to the bash script
            cmd = ' '.join(('sbatch -p bigmem -o '+path+'/sbatch_logs/merge.all.association.results.'+pheno+'.out ./bin/merge.all.association.results.callR.sh',
                                path,pheno,models[i]))
            print 'Merging all results for for phenotype',pheno+':\n',cmd            
            ## Split cmd for shell
            split_cmd = shlex.split(cmd)
            ## Launch command
            sp.call(split_cmd)#,stdout=log_file,stderr=logerr_file)

    print '*************************************'        
    print '******* End JOB:',sys.argv[0]
    print '*************************************\n'
    
if __name__ == '__main__':
    common_variant_analysis_genotyped()

