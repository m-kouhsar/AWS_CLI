#!/bin/bash
#SBATCH -A Research_Project-MRC164847 # research project to submit under.
#SBATCH --export=ALL # export all environment variables to the batch job.
#SBATCH -D . # set working directory to .
#SBATCH -p mrcq # submit to the parallel test queue
#SBATCH --time=5:00:00 # Maximum wall time for the job
#SBATCH --nodes=1 # specify number of nodes.
#SBATCH --ntasks-per-node=16 # specify number of processors.
#SBATCH --mail-type=END # send email at job completion
#SBATCH --mail-user=m.kouhsar@exeter.ac.uk # email address
#SBATCH --job-name=SalmonIndex

source $1 

if [[ "${Destination:0:1}" == "/" ]]
then
    
    Destination="${Destination:1}"
    
fi

if [[ "${Destination: -1}" == "/" ]]
then
    
    Destination="${Destination:0:-1}"
    
fi

if [[ -d $Source ]]
then

    aws s3 cp $Source s3://${Bucket_Name}/${Destination} --recursive
    
    
elif [[ -f $Source ]]
then

    file_name=$( basename $Source )
    aws s3 cp $Source s3://${Bucket_Name}/${Destination}/${file_name}
    
else

    echo "$Source is not valid"
    exit 1
    
fi
