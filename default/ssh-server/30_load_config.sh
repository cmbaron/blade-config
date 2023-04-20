#!/bin/bash -xe

microk8s status --wait-ready

microk8s kubectl apply -f ssh-service.yaml
microk8s kubectl apply -f ssh.yaml
