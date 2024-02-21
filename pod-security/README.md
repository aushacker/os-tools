# Pod Security

aushacker</br>
Feb 2024

A series of sample deployments highlighting various OpenShift 4 security
configurations.

## nonroot

Testing with this container highlights a security weakness. Whilst several
internet articles mentioned ping requiring CAP_NET_RAW, this is not correct
for ubi8, ping works from a container from which ALL capabilities have been
dropped.

## root

Need to manually run `oc adm policy add-scc-to-user anyuid -z sa-sec-root`.
