vault write auth/kubernetes/role/webapp \
        bound_service_account_names=vault \
        bound_service_account_namespaces=vault \
        policies=webapp \
        audience=vault \
        ttl=30d
