variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group for RDS"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.medium"
}

variable "db_password" {
  description = "Master password for the payroll RDS instance"
  type        = string
  sensitive   = true
}
