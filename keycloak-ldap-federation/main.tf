
terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 2.0.0"
    }
  }
}

## Please make secure for production!
provider "keycloak" {
  client_id = "admin-cli"
  username  = "admin"
  password  = "admin"
  url       = "http://localhost:8089"
}

## Example LDAP Federation - adjust values
resource "keycloak_realm" "realm" {
  realm   = "my-realm"
  enabled = true
}

resource "keycloak_ldap_user_federation" "ldap_user_federation" {
  name     = "openldap"
  realm_id = keycloak_realm.realm.id
  enabled  = true

  username_ldap_attribute = "cn"
  rdn_ldap_attribute      = "cn"
  uuid_ldap_attribute     = "entryDN"
  user_object_classes     = [
    "simpleSecurityObject",
    "organizationalRole"
  ]
  connection_url          = "ldap://openldap"
  users_dn                = "dc=example,dc=org"
  bind_dn                 = "cn=admin,dc=example,dc=org"
  bind_credential         = "admin"

  connection_timeout = "5s"
  read_timeout       = "10s"

  kerberos {
    kerberos_realm   = "FOO.LOCAL"
    server_principal = "HTTP/host.foo.com@FOO.LOCAL"
    key_tab          = "/etc/host.keytab"
  }
}

