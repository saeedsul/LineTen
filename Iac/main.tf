terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {} 
resource "docker_network" "demo_network" {
  name = var.network_name
}

resource "docker_image" "mssql_server" {
    name  = "mcr.microsoft.com/mssql/server:2022-latest"
    keep_locally = true
}

resource "docker_container" "mssql_container" {
  name  = "mssql_container"
  image = docker_image.mssql_server.name
  env = ["ACCEPT_EULA=Y", "MSSQL_SA_PASSWORD=Password1!"]
  ports {
    internal = 1433
    external = 1433
  }
   network_mode = var.network_name
}

resource "docker_image" "line_ten_api_image" {
  name  = "lineten:10" 
  keep_locally = true
}

resource "docker_container" "line_ten_api_container" {
  name  = "line_ten_api_container"
  image = docker_image.line_ten_api_image.name
  ports {
    internal = 80
    external = 3000
  }
  ports {
    internal = 443
    external = 3001
  }
  
  depends_on = [docker_container.mssql_container]
  env = [ 
    "ASPNETCORE_ENVIRONMENT=Development", 
    "SQL_SERVER= mssql_container",
    "SQL_USER=SA",  
    "SQL_PASSWORD=Password1!" , 
    "ConnectionStrings__dbConnectionString=Server=mssql_container;Database=TerraformDb;User=SA;Password=Password1!;Encrypt=False;Trust Server Certificate=True;Application Intent=ReadWrite;Multi Subnet Failover=False" 
  ]
  network_mode = var.network_name
}