variable "resource_identifier" {
    type = string
    default = "name"
    description = "Required (name of the aurora)"
}
variable "environment" {
    type = string
    default = "dev"
    description = "Environmet"
}
variable "service" {
  type = string
  default = "voice"
}
variable "subnet" {
  type = list(string)
  default = []
}
variable "db_cluster" {
  type = map(string)
  default = {}
}
