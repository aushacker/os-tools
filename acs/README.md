# ACS Installation & Configuration

May 2023

## Install Operator

Install from the OpenShift marketplace. Use default settings.

## Configure Central

1. Create namespace **acs-central**
1. Create Central CR in NS acs-central
1. Lookup password - Secret central-htpasswd
1. Login to the ACS console as admin
1. Create an init bundle

## Configure SecuredCluster

Doco says this can be in the same namespace as Central but if you do that then scans
of the Openshift internal registry will fail.

1. Create namespace **acs-services**
1. Apply the init bundle (oc apply)
1. Create a SecuredCluster CR in NS acs-services


