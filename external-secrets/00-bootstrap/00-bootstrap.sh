#!/bin/bash

# Installs the External Secrets Operator and applies
# a basic configuration.
#
# Aushacker
# Feb 2024

controller=deployment/external-secrets-operator-controller-manager

echo "Selecting openshift-operators namespace"
oc project openshift-operators

echo "Installing External Secrets Operator"
oc apply -f subscription.yaml

echo "Waiting for controller creation"
while true; do
  oc get $controller >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "."; break
  fi 
  echo -n "."
  sleep 1
done

echo "Waiting for controller to become available"
oc wait --for=condition=Available $controller

echo "Applying operator configuration"
oc apply -f operator-config.yaml
