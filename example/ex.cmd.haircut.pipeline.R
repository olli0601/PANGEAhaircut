#
#	create multiple runs on HPC using the command line version
#
\dontrun{
	
#DATA		<- SET THIS DIRECTORY
indir		<- paste(DATA, 'contigs_150408_wref', sep='/' )
outdir		<- paste(DATA, 'contigs_150408_model150816a', sep='/' )		
batch.n		<- 200
tmp			<- data.table(FILE=list.files(indir, pattern='fasta$', recursive=T))
tmp[, BATCH:= ceiling(seq_len(nrow(tmp))/batch.n)]
tmp			<- tmp[, max(BATCH)]
for(batch.id in seq.int(1,tmp))
{	
	
	cmd			<- cmd.haircut.pipeline(indir, outdir, batch.n=batch.n, batch.id=batch.id)
	cmd			<- cmd.hpcwrapper(cmd, hpc.nproc= 1, hpc.q='pqeelab', hpc.walltime=4, hpc.mem="5000mb")
	cat(cmd)		
	outdir		<- paste(DATA,"tmp",sep='/')
	outfile		<- paste("hrct",paste(strsplit(date(),split=' ')[[1]],collapse='_',sep=''),sep='.')
	cmd.hpccaller(outdir, outfile, cmd)	
}	
}