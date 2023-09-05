variable "location" {
  type = string
  default = "westeurope"
}

variable "db_name" {
  type = string
  default = "db-project"
}

variable "db_username" {
  type = string
  default = "python"
}

variable "db_password" {
  type = string
  default = "pythonTEST123_"
  sensitive = true
}

variable "script" {
  type = string
  default = "testscript.sh"
}