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
#SBATCH --job-name=aws_download

source $1 

if [[ "${Source:0:1}" == "/" ]]
then
    
    Source="${Source:1}"
    
fi

if [[ "${Source: -1}" == "/" ]]
then
    
    Source="${Source:0:-1}"
    
fi


not_exist=$(aws s3api head-object --bucket $Bucket_Name --key $Source >/dev/null 2>&1; echo $?)
if [ $not_exist != 0 ]
then
    # There is no $Source object on cloud. So, we assume that $Source is a directory
    aws --endpoint-url=https://${Endpoint_URL} s3 cp s3://${Bucket_Name}/${Source} $Destination --recursive
else   
    aws --endpoint-url=https://${Endpoint_URL} s3 cp s3://${Bucket_Name}/${Source} $Destination
fi

