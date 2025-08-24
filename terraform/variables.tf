variable "environment" {
  description = "The environment in which the resources will be created."
  type        = string
  default     = "dev"
}



variable "region" {
  default = "us-east-1"

}
variable "instance_type" {
  default = "t3.small"

}

variable "cluster_version" {
  default = "1.30"

}
