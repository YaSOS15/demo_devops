terraform {
  required_version = ">= 1.0"
  
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Configuration du provider Docker
provider "docker" {
  host = "npipe:////./pipe/docker_engine"  # Pour Windows
  # host = "unix:///var/run/docker.sock"   # Pour Mac/Linux (décommentez si besoin)
}

# Créer une image Docker depuis un Dockerfile
resource "docker_image" "mon_image" {
  name = "mon-app:latest"
  
  build {
    context    = "."                    # Dossier contenant le Dockerfile
    dockerfile = "Dockerfile"           # Nom du Dockerfile
    tag        = ["mon-app:latest"]
  }
  
  keep_locally = false  # true = garde l'image localement après destroy
}

# (Optionnel) Créer un conteneur à partir de l'image
resource "docker_container" "mon_conteneur" {
  name  = "mon-app-container"
  image = docker_image.mon_image.image_id
  
  ports {
    internal = 80    # Port dans le conteneur
    external = 8080  # Port sur votre machine
  }
  
  # Redémarrage automatique
  restart = "unless-stopped"
}