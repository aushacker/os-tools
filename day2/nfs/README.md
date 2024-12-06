# NFS Storage

Aushacker<br/>
December 2024

This Kustomization installs a dynamic storage class for NFS.

## Static Storage Allocation

Notes on static allocation of PersistentVolumes from an NFS backend.

```
kind: PersistentVolume
apiVersion: v1
metadata:
  name: pv1
spec:
  capacity:
    storage: 1Gi
  nfs:
    server: ocp-svc.home.lab
    path: /shares/static/pv1
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  volumeMode: Filesystem
```

```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: pv1
  namespace: aaa
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
  volumeName: pv1
  storageClassName: ''
  volumeMode: Filesystem
```

Notes:

1. The PVC references the PV through the volumeName field
1. Empty storageClassName is required to prevent dynamic allocation