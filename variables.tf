variable "aws_region" {
  description = "AWS region donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente de despliegue (dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "lab-vpc"
}

#VPC EXISTENTE
variable "vpc_name" {
  description = "VPC que ya existia donde crearemos todos los recursos"
  type = string
  default = "Lab VPC"
}

#Public subnet
variable "public_subnet_cidr" {
  description = "CIDR block para la subnet"
  type = string
  default = "10.0.0.0/24"
}

variable "availability_zone" {
  description = "Zona de disponibilidad para la subnet publica"
  type = string
  default = "us-east-1a"
}

variable "public_subnet_name" {
  description = "Nombre de la subnet publica"
  type = string
  default = "Public Subnet"
}

#Internet Gateway
variable "igw-name" {
  description = "Nombre del igw"
  type = string
  default = "bation-lab"
}

variable "private_subnet_cidr" {
  description = "CIDR de la subnet privada"
  type = string
  default = "10.0.1.0/24"
}

variable "private_subnet_name" {
  description = "Nombre de la subnet privada"
  type = string
  default = "Private Subnet"
}
