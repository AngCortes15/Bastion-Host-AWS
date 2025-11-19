variable "aws_region" {
  description = "AWS region donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "lab-vpc"
}

# Ejemplo de variables adicionales para VPC
# variable "vpc_cidr" {
#   description = "CIDR block para la VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }

# variable "availability_zones" {
#   description = "Lista de zonas de disponibilidad"
#   type        = list(string)
#   default     = ["us-east-1a", "us-east-1b"]
# }
