terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

# Aquí van tus recursos de infraestructura
# Ejemplo:
# resource "aws_vpc" "main" {
#   cidr_block = var.vpc_cidr
#
#   tags = {
#     Name = "${var.project_name}-vpc"
#   }
# }
