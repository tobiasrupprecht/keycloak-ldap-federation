terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "keycloak" {
  name         = "jboss/keycloak:14.0.0"
  keep_locally = false
}

resource "docker_container" "keycloak" {
  image = docker_image.keycloak.name
  name  = "LDAP-SAML-Federation"
  ports {
    internal = 8080
    external = 8089
  }
  env = ["KEYCLOAK_USER=admin", "KEYCLOAK_PASSWORD=admin"]
}

