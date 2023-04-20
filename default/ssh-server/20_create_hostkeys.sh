#!/bin/bash -xe

microk8s status --wait-ready

kubectl -n default get secret ssh-keys &>/dev/null
RESULT=$?
if [[ $RESULT ]];
    TEMPDIR=$(mktemp -d)
    rm -rf $TEMPDIR
    mkdir $TEMPDIR
    ssh-keygen -q -t rsa  -f $TEMPDIR/ssh_host_rsa_key -N "" -C ""
    ssh-keygen -q -t dsa  -f $TEMPDIR/ssh_host_dsa_key -N "" -C ""
    ssh-keygen -q -t ecdsa  -f $TEMPDIR/ssh_host_ecdsa_key -N "" -C ""
    ssh-keygen -q -t ed25519  -f $TEMPDIR/ssh_host_ed25519_key -N "" -C ""
    kubectl --namespace default create secret generic ssh-host-keys \
    --from-file=$TEMPDIR/ssh_host_rsa_key \
    --from-file=$TEMPDIR/ssh_host_rsa_key.pub \
    --from-file=$TEMPDIR/ssh_host_dsa_key \
    --from-file=$TEMPDIR/ssh_host_dsa_key.pub \
    --from-file=$TEMPDIR/ssh_host_ecdsa_key \
    --from-file=$TEMPDIR/ssh_host_ecdsa_key.pub \
    --from-file=$TEMPDIR/ssh_host_ed25519_key \
    --from-file=$TEMPDIR/ssh_host_ed25519_key.pub
    rm -rf $TEMPDIR
fi
