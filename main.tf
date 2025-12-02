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

#Buscar VPC Existente con Data Source
data "aws_vpc" "existing" {
  tags = {
    Name = var.vpc_name
  }
} 

#Crear public subnet, usamos resource para crear contenido nuevo
resource "aws_subnet" "public" {
  #Asociar vpc con subnet
  vpc_id = data.aws_vpc.existing.id

  #Rango de CIDR
  cidr_block = var.public_subnet_cidr

  #Zona de disponibilidad
  availability_zone = var.availability_zone

  #IP publica automaticamente (Buena practica para subnet publicas (Segun claude xD))
  map_public_ip_on_launch = true

  #Tags para identificar la subnet en la consola
  tags = {
    Name = var.public_subnet_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = data.aws_vpc.existing.id
  tags = {
    Name = "${var.igw-name}-igw"
  }
}

#Route table de Lab VPC
data "aws_route_table" "existing" { #encontrar la route table de nuestra VPC
  vpc_id = data.aws_vpc.existing.id
}

resource "aws_route" "internet_access" { #Agregar nueva ruta al route table
  route_table_id = data.aws_route_table.existing.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id #Target: El Internet Gateway que creamos anteriormente
}

