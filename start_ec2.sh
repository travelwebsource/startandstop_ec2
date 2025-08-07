#!/bin/bash

# This script starts an EC2 instance using AWS CLI.
# Make sure you have AWS CLI installed and configured with appropriate permissions.
# Usage: sh start_ec2.sh

# Prompt user for the EC2 Instance ID
echo "Welcome to the EC2 Instance Starter!"
echo "Please provide the EC2 Instance ID you wish to start."
read -p "Enter the EC2 Instance ID to start: " INSTANCE_ID

if [ -z "$INSTANCE_ID" ]; then
    echo "Instance ID cannot be empty."
    exit 1
else
    # checking if aws cli is installed. if not install it using git bash script
    if ! command -v aws &> /dev/null
    then
        echo "AWS CLI could not be found. Please install AWS CLI to proceed."
        echo "You can install it using the following command:"
        echo "curl \"https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip\" -o \"awscliv2.zip\" && unzip awscliv2.zip && sudo ./aws/install"
        exit 1
    fi
    #check if aws instance is already running
    INSTANCE_STATE=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query "Reservations[*].Instances[*].State.Name" --output text)
    if [ "$INSTANCE_STATE" == "running" ]; then
        echo "Instance $INSTANCE_ID is already running."
        exit 1
    else
        echo "Starting instance $INSTANCE_ID..."
        aws ec2 start-instances --instance-ids "$INSTANCE_ID"
        echo "Instance $INSTANCE_ID has been started."
   
    fi
fi

