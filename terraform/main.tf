terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# ── IAM ──────────────────────────────────────────────────────────────────────

resource "aws_iam_role" "payroll_service" {
  name = "payroll-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
      }
    ]
  })

  tags = {}
}

resource "aws_iam_role_policy" "payroll_service" {
  name = "payroll-service-policy"
  role = aws_iam_role.payroll_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}

# ── Networking ────────────────────────────────────────────────────────────────

resource "aws_security_group" "payroll_app" {
  name        = "payroll-app-sg"
  description = "Security group for payroll service EKS nodes"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Application traffic from VPC"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {}
}

resource "aws_security_group" "payroll_db" {
  name        = "payroll-db-sg"
  description = "Security group for payroll RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from app"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.payroll_app.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {}
}

# ── Database ──────────────────────────────────────────────────────────────────

resource "aws_db_instance" "payroll" {
  identifier        = "payroll-db"
  engine            = "postgres"
  engine_version    = "14.12"
  instance_class    = var.db_instance_class
  allocated_storage = 20
  storage_encrypted = true

  db_name  = "payroll"
  username = "payroll_admin"
  password = var.db_password

  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.payroll_db.id]

  publicly_accessible = true
  skip_final_snapshot = true

  tags = {}
}
