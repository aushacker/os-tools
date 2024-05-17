#!/bin/bash

echo "Installing Subscription and OperatorGroup"
oc apply -f ./operator.yaml

echo
echo "Waiting for ClusterServiceVersion"
sleep 10
oc wait --for=jsonpath='{.status.phase}'=Succeeded csv/kubevirt-hyperconverged-operator.v4.14.5 -n openshift-cnv

echo
echo "Installing Hyperconverged CR"
oc apply -f ./hyperconverged.yaml

echo
echo "Waiting for Hyperconverged to become Available"
sleep 10
oc wait --for=condition=Available=True hyperconverged/kubevirt-hyperconverged -n openshift-cnv --timeout=600s
