# AWS_CLI

These scripts are writen to configure and copy data from your local storage to Amazon Relational Database Service using AWS CLI tool. 

## Installation
`
conda install -c conda-forge awscli
`
## Configuration
Set the variable in aws.args file and then run the following command\n:
`
bash aws.config.sh aws.args
`
## Copying files 
Set the variable in aws.args file and then run the following command:
`
bash aws.copy.sh aws.args
`

If you set the `Source` variable to a directory, all files in that directory will be copied to `Destination`.
