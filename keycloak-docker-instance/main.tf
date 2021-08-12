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

## Please make secure for production!
resource "docker_container" "keycloak" {
  image = docker_image.keycloak.name
  name  = "SAML-for-TFE"
  ports {
    internal = 8080
    external = 8089
  }
  env = ["KEYCLOAK_USER=admin", "KEYCLOAK_PASSWORD=admin"]
}

