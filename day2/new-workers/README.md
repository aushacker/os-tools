# Adding Workers

aushacker<br/>
July 2024

## Overview

Supporting code for adding worker nodes to an existing OpenShift cluster. Can
be applied to Single Node OpenShift (SNO) or disconnected clusters created with
the agent installer.

Creates an nginx deployment hosting the required ignition files.

Instructions for SNO can also be used for clusters created with agent based installer, see https://docs.redhat.com/en/documentation/openshift_container_platform/4.15/html/nodes/worker-nodes-for-single-node-openshift-clusters#sno-adding-worker-nodes-to-single-node-clusters-manually_add-workers

## CoreOS ISO Download

Login as cluster-admin.

```
$ git clone https://github.com/aushacker/os-tools.git
$ cd os-tools/day2/new-workers
```

Check script variables in iso-download.sh.



```

$ oc extract -n openshift-machine-api secret/worker-user-data-managed --keys=userData --to=- > worker.ign
```

Follow instructions for 

```
oc csr
```
