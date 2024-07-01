# OpenLDAP Notes

aushacker<br/>
July 2024

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
olcSuffix: dc=example,dc=lan

dn: olcDatabase={2}mdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=Manager,dc=example,dc=lan

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
# ldapsearch -H ldapi:// -Y EXTERNAL -b 'cn=schema,cn=config' -s one -LLL -Q dn

# ldapadd -H ldapi:// -Y EXTERNAL -f /etc/openldap/schema/cosine.ldif
# ldapadd -H ldapi:// -Y EXTERNAL -f /etc/openldap/schema/inetorgperson.ldif

# ldapsearch -H ldapi:// -Y EXTERNAL -b 'cn=schema,cn=config' -s one -LLL -Q dn
```

## OrganizationalUnits

ou.ldif:
```
dn: dc=example,dc=lan
dc: example
objectClass: domain

dn: ou=Users,dc=example,dc=lan
objectClass: organizationalUnit
ou: Users

dn: ou=Groups,dc=example,dc=lan
objectClass: organizationalUnit
ou: Groups

dn: ou=System,dc=example,dc=lan
objectClass: organizationalUnit
ou: System
```

Apply and verify:
```
# ldapadd -H ldap:// -D "cn=Manager,dc=example,dc=lan" -W -f ou.ldif

# ldapsearch -H ldap:// -D "cn=Manager,dc=example,dc=lan" -W -b 'dc=example,dc=lan' '(ou=*)'
```

## Bibliography

1. https://www.digitalocean.com/community/tutorials/how-to-configure-openldap-and-perform-administrative-ldap-tasks
2. Mastering OpenLDAP: Configuring, Securing and Integrating Directory Services
