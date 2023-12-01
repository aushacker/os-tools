# OpenShift GitOps
Aushacker</br>
December 2023

## Operator Installation

`oc apply -f bootstrap/subscription-gitops.yaml`

Login using the hardcoded admin account. Password is found in Secret
openshift-gitops/openshift-gitops-cluster.

## Repository Creation

Repositories can be created via UI using the admin account or
via an appropriately annotated Secret.

`oc apply -f repos/repo-os-tools.yaml`

## Application Deployment

`oc apply -f apps/application-apps.yaml`

The default ServiceAccount has insufficient permissions to create
the required resources in other namespaces. The account should be
granted additional permissions to target namespaces e.g.:

`oc apply -f apps/rolebinding-nginx.yaml`
