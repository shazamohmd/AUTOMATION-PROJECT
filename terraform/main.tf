module "networks" {
  source = "./Module/networks"

  project_name   = var.project_name
  vpc_cidr       = var.vpc_cidr
  aws_region     = var.aws_region
  container_port = var.container_port
  subnet_cidr    = var.subnet_cidr
}

module "ecscluster" {
  source = "./Module/cluster"

  project_name = var.project_name
}

module "task" {
  source = "./Module/task"

  project_name    = var.project_name
  aws_region      = var.aws_region
  container_image = var.container_image
  container_port  = var.container_port
  task_cpu        = var.task_cpu
  task_memory     = var.task_memory
}

data "aws_ecs_task_execution" "myapp" {
  cluster         = module.ecscluster.cluster_name
  task_definition = module.task.task_definition_arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [module.networks.public]
    security_groups  = [module.networks.securitygroup]
    assign_public_ip = true
  }

  depends_on = [
    module.ecscluster.cluster_id,
    module.task.task_definition_arn,
    module.networks.public,
    module.networks.securitygroup
  ]
}