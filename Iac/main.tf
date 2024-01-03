terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

resource "docker_network" "demo_network" {
  name = var.network_name
}

resource "docker_image" "mssql_server" {
  name         = "mcr.microsoft.com/mssql/server:2022-latest"
  keep_locally = true
}

locals {
  secrets_content = file("${path.module}/secrets.txt")

  content_debug = local.secrets_content

  secrets = {
    for line in split("\n", local.secrets_content) :
    split(":", line)[0] => split(":", line)[1] if length(split(":", line)) > 1
  }

  mssql_sa_password = try(base64decode(replace(local.secrets["SQL_SA_PASSWORD"], "/\\s/g", "")), null)
}

output "mssql_sa_password" {
  description = "MSSQL SA Password"
  value       = local.mssql_sa_password
}

resource "docker_container" "mssql_container" {
  name  = "mssql_container"
  image = docker_image.mssql_server.name
  env = [
    "ACCEPT_EULA=Y",
    "MSSQL_SA_PASSWORD=${local.mssql_sa_password}"
  ]
  ports {
    internal = 1433
    external = 1433
  }

  volumes {
    volume_name    = var.db_volume_name
    container_path = var.db_volume_path
    read_only      = false
  }

  network_mode = var.network_name
}

resource "docker_image" "line_ten_api_image" {
  name         = "lineten:10"
  keep_locally = true
}

resource "docker_container" "line_ten_api_container" {
  name  = "line_ten_api_container"
  image = docker_image.line_ten_api_image.name
  ports {
    internal = 80
    external = 3000
  }

  depends_on = [docker_container.mssql_container]
  env = [
    "ASPNETCORE_ENVIRONMENT=Development",
    "SQL_SERVER=mssql_container",
    "SQL_USER=SA",
    "SQL_PASSWORD=${local.mssql_sa_password}",
    "ConnectionStrings__dbConnectionString=Server=mssql_container;Database=TerraformDb;User=SA;Password=${local.mssql_sa_password};Encrypt=False;Trust Server Certificate=True;Application Intent=ReadWrite;Multi Subnet Failover=False"
  ]
  network_mode = var.network_name
} 