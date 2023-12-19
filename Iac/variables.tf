variable "network_name" {
  description = "Name of the Docker network"
  default     = "demo_network"
}

variable "mssql_container_name" {
  description = "Name of the MSSQL container"
  default     = "mssql_container"
}

variable "line_ten_container_name" {
  description = "Name of the LineTen API container"
  default     = "line_ten_api_container"
}

variable "volume_name" {
  description = "Name of the Docker volume"
  default     = "database"
}

variable "volume_path" {
  default     = "/var/opt/mssql/"
  description = "Container volume path"
}
