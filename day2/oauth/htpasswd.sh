#!/bin/bash

#
# Creates an account with cluster-admin rights.
#
# 1. Install htpasswd utility (RedHat package httpd-tools)
# 2. Login as kubeadmin (or other cluster-admin)
#
# aushacker
# March 2024

if [ "$#" -ne 1 ]; then
    echo "usage: $0 username"
    exit 1
fi

username=$1
read -s -p "password> " password

case $(uname) in
Darwin)
    OPTS=-nBb
    ;;
Linux)
    OPTS=-cBb
    ;;
*)
    echo "Unknown distro"
    echo 1
    ;;
esac

credentials=$(htpasswd $OPTS $username $password)

echo
echo
echo "Creating Secret"
oc create secret generic -n openshift-config htpasswd-secret --from-literal=htpasswd="$credentials"

echo
echo "Patching OAuth cluster resource"
oc patch oauth cluster --type='merge' --patch='{"spec":{"identityProviders":[{"name":"htpasswd","type":"HTPasswd","mappingMethod":"claim","htpasswd":{"fileData":{"name":"htpasswd-secret"}}}]}}'

echo
echo "Granting cluster-admin"
oc adm policy add-cluster-role-to-user cluster-admin $username
