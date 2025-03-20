# OpenShift GitOps
Aushacker</br>
March 2025

## Operator Installation

Installs the OpenShift GitOps operator from bootstrap.

`./01-install-gitops`

NB. No default ArgoCD instance.

## ArgoCD Instance Creation

`oc apply -k overlays\core`

Login using the hardcoded admin account. Password is found in Secret
openshift-gitops/openshift-gitops-cluster.

## Repository Creation

Repositories can be created via UI using the admin account or
via an appropriately annotated Secret.

See base/repo-os-tools.yaml.

## Application Deployment

`oc apply -f apps/application-apps.yaml`

The default ServiceAccount has insufficient permissions to create
the required resources in other namespaces. The account should be
granted additional permissions to target namespaces e.g.:

`oc apply -f apps/rolebinding-dev-tools.yaml`
`oc apply -f apps/rolebinding-nginx.yaml`
