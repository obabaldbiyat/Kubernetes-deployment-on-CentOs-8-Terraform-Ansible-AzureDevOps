#!/bin/bash
terraform output -raw private > id_rsa
sudo chmod 400 id_rsa
sudo echo -e "[kubernetes-master-nodes]\n\nmanager ansible_host=$(terraform output -raw IP_pub_manager) ansible_user=azureuser\nmanager ansible_ssh_private_key_file=id_rsa\n\n[kubernetes-worker-nodes]\n\nworker0 ansible_host=$(terraform output -raw IP_pub_worker_0) ansible_user=azureuser\nworker0 ansible_ssh_private_key_file=id_rsa\n\nworker1 ansible_host=$(terraform output -raw IP_pub_worker_1) ansible_user=azureuser\nworker1 ansible_ssh_private_key_file=id_rsa" > hosts
