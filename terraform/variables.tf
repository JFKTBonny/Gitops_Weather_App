variable "environment" {
  description = "The environment in which the resources will be created."
  type        = string
  default     = "real"
}

# variable "location" {
#   description = "The location in which the resources will be created."
#   type        = string
#   default     = "switzerlandnorth"

# }

# variable "rg" {
#   description = "The name of the resource group in which to create the resources."
#   type        = string
#   default     = "gitops-real-rg"
# }

variable "region" {
  default = "us-east-1"

}
variable "instance_type" {
  default = "t3.small"

}

variable "cluster_version" {
  default = "1.30"

}
variable "cluster_security_group_id" {
  default = null
}