# ODF Operator Configuration

aushacker</br>
March 2024

Installs the ODF Operator and configures an external Ceph cluster.

`helm install odf-operator ./odf -n openshift-storage --set externalCluster.details="external JSON"`

## Bibliography

* https://access.redhat.com/articles/6318251
