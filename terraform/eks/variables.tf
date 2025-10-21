variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster and nodes"
  type        = list(string)
}

variable "sg_ids" {
  description = "List of security group IDs for the EKS cluster and node access"
  type        = list(string)
}
