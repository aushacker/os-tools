#!/bin/bash

# Install NMState Operator
oc apply -k .

# Wait for install to complete

# Create CR
oc apply -f nmstate.yaml

# Wait for operator configuration

# Label nodes
for i in $(seq 1 3);
do
  oc label node/ocp-w-${i}.lab.ocp.lan external-network=true
done

# Install configuration policy (nncp)
oc apply -f nncp.yaml
