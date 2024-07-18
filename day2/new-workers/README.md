# Adding Workers

aushacker<br/>
July 2024

## Overview

Supporting code for adding worker nodes to an existing OpenShift cluster. Can
be applied to Single Node OpenShift (SNO) or disconnected clusters created with
the agent installer.

Creates an HTTP server (nginx) hosting the required ignition files.

Instructions for SNO can also be used for clusters created with agent based installer, see https://docs.redhat.com/en/documentation/openshift_container_platform/4.15/html/nodes/worker-nodes-for-single-node-openshift-clusters#sno-adding-worker-nodes-to-single-node-clusters-manually_add-workers

## CoreOS ISO Download

Login as cluster-admin.

```
$ git clone https://github.com/aushacker/os-tools.git
$ cd os-tools/day2/new-workers
```

Check script variables in iso-download.sh, then run the script:

```
$ ./iso-download.sh
```

Upload the ISO to the hypervisor .iso file library.

## Nginx Image Location (Optional)

If cluster is in a disconnected environment then edit overlays/basic/kustomization.yaml,
updating the image location to the air gapped mirror server.

## Ignition File Configuration

A ConfigMap is used to store the ignition files served up by nginx, this needs to be manually edited:

1. `cat worker.ign` NB - worker.ign is output by iso-download.sh script
1. Copy text to the clipboard
1. `nano overlays/basic/cm-static-content.yaml`
1. Paste the copied worker.ign text into the indicated location
1. Locate the new-worker.ign section
1. (Optional) Rename section e.g. WorkerN.ign
1. Modify values for cluster-name, base-domain and worker-name
1. (Optional) Copy section WorkerN.ign to WorkerN+1.ign and repeat previous step. This allows for multi-node additions
1. Save & exit

## HTTP Server Deployment

```
Deploy the HTTP server:

$ oc create --save-config -k overlays/basic

Check operation:

$ curl http://ignition-cluster-tools.apps.<cluster-name>.<base-domain>/worker.ign
$ curl http://ignition-cluster-tools.apps.<cluster-name>.<base-domain>/new-worker.ign
```

## Create Worker

1. Create the new worker VM and assign the downloaded coreos ISO as its boot volume
1. Start the VM
1. In the VM console follow the RH docs to optionally configure the networking

```
With static network:

$ sudo coreos-installer install --copy-network --ignition-url=http://ignition-cluster-tools.apps.<cluster-name>.<base-domain>/new-worker.ign /dev/sda --insecure-ignition

With dhcp network:

$ sudo coreos-installer install --ignition-url=http://ignition-cluster-tools.apps.<cluster-name>.<base-domain>/new-worker.ign /dev/sda --insecure-ignition

When the installer completes, reboot.
```

Wait for certificates (patience required):

```
$ oc get csr

When Pending requests appear:

$ oc adm certificate approve <csr_name>
```

## Completion

Test for worker status i.e. Ready:
```
$ oc get node
```
