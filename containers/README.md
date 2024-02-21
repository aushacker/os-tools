# Utility Containers

aushacker</br>
February 2024

Create containers for testing.

Depends on dev-tools being installed (uses generic-build pipeline).

## maven

An alternate version of the OpenShift Pipelines maven ClusterTask. Differs from the
original as it allows a PVC to be configured for the maven .m2 cache, speeding up builds considerably.

## sec-base

Ubi8 based container with additional commands installed:
1. ps
1. capsh

Container runs as root.

## sec-user

Based from sec-base. Adds user 1000.

Container intended to run as non-root user.
