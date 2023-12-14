#!/bin/bash
#_BUILDAH_STARTED_IN_USERNS=""
#BUILDAH_ISOLATION=chroot
#STORAGE_DRIVER=vfs
ctr=$(buildah from registry.access.redhat.com/ubi8/ubi-micro)
mnt=$(buildah mount $ctr)
dnf upgrade -y --installroot $mnt --disableplugin=subscription-manager
dnf install -y --installroot $mnt --disableplugin=subscription-manager --setopt=tsflags=nodocs bind-utils
dnf clean all --installroot $mnt --disableplugin=subscription-manager
#buildah config --entrypoint /bin/bash $ctr
buildah commit $ctr localhost/myhttp
#buildah push localhost/myhttp quay.io/sdavies/myhttp
