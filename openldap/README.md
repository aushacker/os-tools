# OpenLDAP Deployment Notes

aushacker<br/>
June 2023

Deploys the Bitnami OpenLDAP container image hosted on Docker hub to OpenShift 4. Tested on OCP 4.12.

Example (using oc debug node):

```curl -v -u 'cn=admin,dc=example,dc=org':adminpassword "ldap://<pod ip>:1389/cn=user01,ou=users,dc=example,dc=org"```

Note that the daata dir is ephemeral (emptyDir). This is deliberate. The Bitnami OpenLDAP 2.6 scripts
are written such that setup only occurs once. This is controlled by the data directory, if it exists
then initialisation does not happen. This includes TLS configuration.
