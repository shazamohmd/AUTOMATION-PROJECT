variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}
variable "vpc_cidr" {
  description = "The VPC range"
  type        = string
}

variable "subnet_cidr" {
  description = "The subnet range"
  type        = string
}
variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "container_image" {
  description = "Docker image to deploy"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}


variable "task_cpu" {
  description = "CPU  for the ECS task "
  type        = number
}

variable "task_memory" {
  description = "Memory for the ECS task (in MiB)"
  type        = number
}

