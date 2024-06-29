# OpenLDAP Notes

aushacker<br/>
June 2024

## Installation

```
# dnf install -y openldap openldap-clients openldap-servers

# systemctl enable slapd.service

# systemctl start slapd.service

# ldapsearch -H ldapi:// -Y EXTERNAL -b 'cn=config' '(olcRootDN=*)'
```

## Modify Base Domain and Admin Account

Use `slappasswd` to encrypt a password for the admin account.

Create custom.ldif:
```
dn: olcDatabase={2}mdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=ocp,dc=lan

dn: olcDatabase={2}mdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=admin,dc=ocp,dc=lan

dn: olcDatabase={2}mdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: <password>
```

Apply the changes and verify:
```
# sudo ldapmodify -H ldapi:// -Y EXTERNAL -f custom.ldif

# ldapsearch -H ldapi:// -Y EXTERNAL -b 'cn=config' '(olcRootDN=*)'
```

## Additional Schema

The default install only contains the core schema. The cosine schema includes objectClass domain:
```
# ldapsearch -H ldapi:// -Y EXTERNAL -b 'cn=schema,cn=config' -s one -LLL -Q dn'

# ldapadd -H ldapi:// -Y EXTERNAL -f /etc/openldap/schema/cosine.ldif

# ldapsearch -H ldapi:// -Y EXTERNAL -b 'cn=schema,cn=config' -s one -LLL -Q dn'
```

## OrganizationalUnits

ou.ldif:
```
dn: dc=ocp,dc=lan
dc: ocp
objectClass: domain

dn: ou=People,dc=ocp,dc=lan
ou: People
objectClass: organizationalUnit

dn: ou=Groups,dc=ocp,dc=lan
ou: Groups
objectClass: organizationalUnit
```

## Bibliography

1. https://www.digitalocean.com/community/tutorials/how-to-configure-openldap-and-perform-administrative-ldap-tasks