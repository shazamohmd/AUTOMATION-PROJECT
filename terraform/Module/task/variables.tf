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

