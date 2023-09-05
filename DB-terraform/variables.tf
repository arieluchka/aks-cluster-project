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
  default = "arieluchka"
}

variable "db_password" {
  type = string
  default = "z1z2z3z4z5Z1Z2Z3_"
  sensitive = true
}

variable "script" {
  type = string
  default = "testscript.bash"
}