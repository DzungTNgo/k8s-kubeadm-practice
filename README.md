# Kubernetes Basic with kubeadm

## Description
This repo is used to practice setting up a kubernetes cluster from scratch using kubeadm.

## Prerequisite
- vagrant

## Usage
- `vagrant up`: create 3 nodes, 1 master and 2 agents
- `setup.sh`: shell script file with commands to set up each node before installing kubernetes components
- `docker.sh`: shell script file to install and set up docker
- `k8s-install.sh`: shell script file to set up kubernetes cluster using kubeadm