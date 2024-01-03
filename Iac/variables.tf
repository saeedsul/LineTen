
variable "docker_host" {
  default = "npipe:////.//pipe//docker_engine"
  type    = string
}

variable "network_name" {
  description = "Name of the Docker network"
  default     = "line_network"
}

variable "mssql_container_name" {
  description = "Name of the MSSQL container"
  default     = "mssql_container"
}

variable "line_ten_container_name" {
  description = "Name of the LineTen API container"
  default     = "line_ten_api_container"
}

variable "db_volume_name" {
  default = "terraform-database_data"
  type    = string
}

variable "db_volume_path" {
  default = "/var/opt/mssql/"
  type    = string
}