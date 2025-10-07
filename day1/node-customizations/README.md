# Node Customizations

aushacker</br>
October 2025

## Overview

A bunch of tweaks to customize OpenShift nodes during installation. Kudos to [John Call](https://hackmd.io/@johnsimcall/S1_fuwzyA).

When using OpenShift agent based installation place the generated MachineConfig files in the \<clusterName\>/openshift directory.

### Partition Root Disk

Useful when the cluster nodes have oversized root partitions. OpenShift generally requires 120-150Gi for the node disk. Anything above this wasted.

Once installed the LVM Storage operator can be configured to use the left over space. By specifying a partition label the LVM operator can use /dev/disk/by-partlabel/\<label\> to identify the correct partition.

The trade off is this. By default the root partition is used for etcd, this requires a high performance disk. Placing other storage on the same disk in a separate partition may have a negative impact if it also has high IOPS.
