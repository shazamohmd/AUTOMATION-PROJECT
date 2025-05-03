# Create a VPC
resource "aws_vpc" "ecs_vpc" {
  cidr_block           = var.vpc_cidr
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Create public subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = "${var.aws_region}a"
  
  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

output "public" {
  value       = aws_subnet.public_subnet.id
  description = "The ID of the public subnet"
}


# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ecs_vpc.id
  
  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Create Route Table
resource "aws_route_table" "routing" {
  vpc_id = aws_vpc.ecs_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
  tags = {
    Name = "${var.project_name}-routing"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.routing.id
}

# Create Security Group for ECS tasks
resource "aws_security_group" "ecs_sg" {
  name        = "${var.project_name}-ecs-sg"
  description = "Security group for ECS tasks"
  vpc_id      = aws_vpc.ecs_vpc.id
  
  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.project_name}-ecs-sg"
  }
}
output "securitygroup" {
  value       = aws_security_group.ecs_sg.id
  description = "The ID of the security group"
}
