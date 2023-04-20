#!/bin/bash -xe

microk8s status --wait-ready

kubectl --namespace default delete secret ssh-keys
kubectl --namespace default create secret generic ssh-keys --from-file=authorized_keys
