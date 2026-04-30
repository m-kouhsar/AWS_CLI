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
#SBATCH --job-name=aws_upload

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
    echo "##########################################################################################################################################"
    echo "Source is a directory. The following command will be used to upload a copy of all files and folders in '${Source}' to '${Bucket_Name}/${Destination}'"
    echo ""
    echo "aws --endpoint-url=https://${Endpoint_URL} s3 cp $Source s3://${Bucket_Name}/${Destination} --recursive --no-progress --cli-read-timeout 0"
    echo ""
    echo "List of all source files:"
    echo ""
    echo "$(find $Source -type f -printf "%p\t%s\n" | numfmt --to=iec --field=2)" 
    echo ""
    echo "##########################################################################################################################################"
    echo "Uploading..."


    aws --endpoint-url=https://${Endpoint_URL} s3 cp $Source s3://${Bucket_Name}/${Destination} --recursive --no-progress --cli-read-timeout 0
    
    
elif [[ -f $Source ]]
then
    echo "##########################################################################################################################################"
    echo "Source is a single file. The following command will be used to upload a copy of '${Source}' to '${Bucket_Name}/${Destination}'"
    echo ""
    echo "aws --endpoint-url=https://${Endpoint_URL} s3 cp $Source s3://${Bucket_Name}/${Destination} --recursive --no-progress --cli-read-timeout 0"
    echo ""
    echo "##########################################################################################################################################"
    echo "Uploading..."

    file_name=$( basename $Source )
    
    aws --endpoint-url=https://${Endpoint_URL} s3 cp $Source s3://${Bucket_Name}/${Destination}/${file_name} --no-progress --cli-read-timeout 0
    
else

    echo "$Source is not valid"
    exit 1
    
fi
