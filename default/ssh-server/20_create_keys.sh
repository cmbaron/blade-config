#!/bin/bash -xe

microk8s status --wait-ready

kubectl --namespace default delete secret ssh-keys &>/dev/null || echo "no keys previously created"
kubectl --namespace default create secret generic ssh-keys --from-file=authorized_keys
