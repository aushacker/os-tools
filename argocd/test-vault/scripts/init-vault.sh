#!/bin/sh

echo -e "\n*** Installing Vault ***\n"

helm upgrade --install vault vault \
    --repo https://helm.releases.hashicorp.com \
    --namespace vault \
    --create-namespace \
    --set "global.openshift=true" \
    --set "server.dev.enabled=true" \
    --set "injector.enabled=false"

sleep 20

echo -e "\n*** Configuring Vault ***\n"

oc --namespace vault cp configure-vault.sh vault-0:/tmp/configure-vault.sh

oc --namespace vault exec vault-0 -t -- sh -c 'cd /tmp && ./configure-vault.sh'

echo -e "\n*** Configuring Policy ***\n"

oc --namespace vault exec vault-0 -- vault write auth/kubernetes/role/vplugin \
    bound_service_account_names=vplugin \
    bound_service_account_namespaces=openshift-gitops \
    policies=vplugin \
    ttl=24h
