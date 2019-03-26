# This repository contains code to create a VPC on AWS and run K8S cluster on it

## Pre-setup folder
This folder contains code to create a state store for the Terraform. The state of this folder is in the folder itself. This is the first folder you should apply.

## Network
This is the second folder you should apply.
It contains definitions of the VPC, routing table and three subnets.

## K8s
This folder should be applied next.
It creates ECR repository to store the docker images and S3 bucket for the Kops state.

## Application
This folder doesn't have Terraform code, it has an "application", which we will be deploying. It is a single `index.html` file, which will be dockerized into an `nginx` base image.
Some manual steps are required here.

First you need to obtain the ECR credentials.
`aws ecr get-login --region eu-central-1 --no-include-email`
It will give the docker login command. Just copy and execute the output.
Next step is you build your image, tag and push it. Make sure you're in the `application` folder when doing this.
1. `docker build -t clustered-ngingx .`

2. `1231231231231` here and in the next step should be replaced with your AWS account. You can get the full URL in the management console or in the output of previously executed `K8S` folder.
`docker tag clustered-ngingx:latest 1231231231231.dkr.ecr.eu-central-1.amazonaws.com/docker-images:latest`

3. docker push 1231231231231.dkr.ecr.eu-central-1.amazonaws.com/docker-images:latest

## Bastion
This folder should be applied the last.
It is the biggest one and it creates a machine, which would be a bastion in usual case. Here it's role is extended and it is also a cluster builder and manager. It is not secure, so please don't use such configuration in production!

The cluster creation and deployment happens using cloud init task. Something may go wrong because of the waiting time for certain commands, so I recommend going to the machine after ~10 minutes and checking the `/var/log/cloud-init-output.log` for the cloud init execution logs.

In order to access the machine, you need your SSH key to be passed to the machine. You can do this by changing/adding key in the `ssh.tf`.
