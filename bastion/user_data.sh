#!/bin/bash
echo "installing KOPS..."
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y apt-transport-https
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

echo "installing Kubectl..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

echo "KOPS preconfiguration..."
sudo su ubuntu
cd /home/ubuntu
pwd
ssh-keygen -b 2048 -t rsa -f /home/ubuntu/.ssh/id_rsa -q -N ""
kops create secret --name kirill.krypton.berlin --state s3://kubernetes-remote-state-storage-s3-kzonov sshpublickey admin -i ~/.ssh/id_rsa.pub

echo "creating cluster..."
kops create cluster --state s3://kubernetes-remote-state-storage-s3-kzonov --zones "eu-central-1a,eu-central-1b" --name kirill.krypton.berlin --yes
sleep 600
kops validate cluster --state s3://kubernetes-remote-state-storage-s3-kzonov
kubectl get nodes
kubectl get pods

echo "creating kubectl config files"
mkdir kubectl-config && cd kubectl-config
echo "apiVersion: apps/v1
kind: Deployment
metadata:
  name: node-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: node-app
  template:
    metadata:
      labels:
        app: node-app
    spec:
      containers:
      - name: node-app
        image: 898846401548.dkr.ecr.eu-central-1.amazonaws.com/docker-images:latest
        ports:
        - containerPort: 80" > nginx-deployment.yml

echo "apiVersion: v1
kind: Service
metadata:
  name: node-lb
  # annotations:
  #   service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
  selector:
    app: node-app" > nginx-lb.yml

echo "deploying the application..."
kubectl create -f nginx-deployment.yml
sleep 60

echo "deploying the load balancer..."
kubectl create -f nginx-lb.yml
sleep 600
kubectl describe service nging-lb
