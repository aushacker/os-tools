# External Secrets Example using Azure Key Vault

* Uses ClusterSecretStore and ClusterExternalSecret
* Set up to allow for distinct key vaults per environment
* Each environment uses its own namespace (name suffixed)
* Overlay kustomization.yaml uses patches and replacements to sync it all up
