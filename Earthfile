VERSION 0.6
FROM alpine

cluster-iso:
    ARG AURORABOOT_VERSION=v0.2.3
    ARG AURORABOOT_IMAGE=quay.io/kairos/auroraboot:$AURORABOOT_VERSION
    ARG ISO_NAME=baronos
    ARG --required CLUSTER_NAME
    ARG overlay=overlay/files-iso
    ARG CONFIG_FILE=baronos/clusters/$CLUSTER_NAME/cloud_config.yaml
    FROM $AURORABOOT_IMAGE

    RUN mkdir -p /tmp/iso-data/boot/grub2
    COPY baronos/iso-overlay/grub.cfg /tmp/iso-data/boot/grub2
    COPY baronos/aurora.yaml /tmp/aurora.yaml
    COPY $CONFIG_FILE /tmp/iso-data
    RUN perl -pi -e "s|\{\{ CONFIG_URL \}\}|https://raw.githubusercontent.com/cmbaron/blade-config/main/$CONFIG_FILE|" /tmp/iso-data/boot/grub2/grub.cfg

    RUN /usr/bin/auroraboot --set "iso.data=/tmp/iso-data" --set "state_dir=/tmp/auroraboot" /tmp/aurora.yaml

    SAVE ARTIFACT /tmp/auroraboot/iso/kairos.iso $ISO_NAME.iso AS LOCAL build/$ISO_NAME.iso
    SAVE ARTIFACT /tmp/auroraboot/iso/kairos.iso.sha256 $ISO_NAME.iso.sha256 AS LOCAL build/$ISO_NAME.iso.sha256
