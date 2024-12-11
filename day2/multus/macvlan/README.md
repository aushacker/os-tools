# Multus macvlan Example

Aushacker<br/>
December 2024

Use multus to connect Pods directly to a second ethernet NIC. An external DHCP server
is required. The OpenShift CNO needs configuration for DHCP as this enables a
'helper' on the node.

```
apiVersion: operator.openshift.io/v1
kind: Network
metadata:
  name: cluster
spec:
  additionalNetworks:
  - name: dhcp-shim
    namespace: default
    type: Raw
    rawCNIConfig: |-
      {
        "name": "dhcp-shim",
        "cniVersion": "0.3.1",
        "type": "bridge",
        "ipam": {
          "type": "dhcp"
        }
      }
  # ...
  ```
