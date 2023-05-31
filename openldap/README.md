# OpenLDAP Deployment Notes

aushacker<br/>
May 2023

Deploys the Bitnami OpenLDAP container image hosted on Docker hub to OpenShift 4. Tested on OCP 4.12.

Example (using oc debug node):

```curl -v -u 'cn=admin,dc=example,dc=org':adminpassword "ldap://<pod ip>:1389/cn=user01,ou=users,dc=example,dc=org"```
