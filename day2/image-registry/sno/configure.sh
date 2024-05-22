#!/bin/sh
#
# Configures the internal OpenShift registry for use.
# aushacker
# May 2024
#
oc patch config cluster --type='json' --patch='[{"op":"replace","path":"/spec/managementState","value":"Managed"}]'
oc patch config cluster --type='json' --patch='[{"op":"add","path":"/spec/storage","value":{}}]'
oc patch config cluster --type='json' --patch='[{"op":"add","path":"/spec/storage/pvc","value":{}}]'
