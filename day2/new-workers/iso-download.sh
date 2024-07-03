#!/bin/sh
#
# Download and extract an installable coreos ISO.
# Run on an internet connected host.
#

OCP_VERSION=latest-4.15
ARCH=x86_64
#ARCH=aarch64

echo "Downloading platform installer"
echo
curl -k https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$OCP_VERSION/openshift-install-linux.tar.gz > openshift-install-linux.tar.gz
tar zxvf openshift-install-linux.tar.gz
chmod +x openshift-install

ISO_URL=$(./openshift-install coreos print-stream-json | grep location | grep $ARCH | grep iso | cut -d\" -f4)
echo "Iso: $ISO_URL"
echo

echo "Downloading ISO"
echo
curl -L $ISO_URL -o rhcos-live.iso
