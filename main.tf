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

# Obtener mi IP Publica para usarla en el SG
data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

#Obtener datos de la AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "al2023-ami-*-x86_64" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]

  }
}

#Obtener el key pair existente
data "aws_key_pair" "vockey" {
  key_name = "vockey"
}

#Creacion del SG para el BastionHost (No se pudo crear, por lo tanto lo hice desde la consola y voy a referenciar a el)

# resource "aws_security_group" "bastion" { #Creacion
#   name = "Bastion Host SG"
#   description = "SG para el Bastion Host - permitir SSH solo desde mi IP"
#   vpc_id = data.aws_vpc.existing.id
#   # Bloque lifecycle: CRÍTICO para AWS Academy
#     # Evita que Terraform intente modificar las reglas de egress por defecto
#   lifecycle {
#     ignore_changes = [egress]
#   }
#   # ingress{
#   #   description = "SSH desde mi IP"
#   #   from_port = 22
#   #   to_port = 22
#   #   protocol = "tcp"
#   #   # cidr_blocks: Lista de rangos IP permitidos
#   #   # Usamos mi IP actual y agregamos /32 (significa solo esa IP exacta)
#   #   # chomp() elimina el salto de linea del resultado HTTP
#   #   # trimspace() elimina espacios en blanco
#   #   cidr_blocks = ["${chomp(trimspace(data.http.my_ip.response_body))}/32"]
#   # }
#   # egress{
#   #   description = "Permitir todo el trafico de salida"
#   #   from_port = 0
#   #   to_port = 0
#   #   protocol = "-1" #protocol = "-1" significa TODOS los protocolos (TCP, UDP, ICMP, etc.)
#   #   cidr_blocks = ["0.0.0.0/0"]
#   # }
#   tags = {
#     Name = "Bastion Host SG"
#   }
# }
# #Reglas de I/O para el BastionHost
# resource "aws_security_group_rule" "bastion_ssh" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["${chomp(trimspace(data.http.my_ip.response_body))}/32"]
#   security_group_id = aws_security_group.bastion.id
#   description       = "SSH desde mi IP"
# }

data "aws_security_group" "bastion" {
  vpc_id = data.aws_vpc.existing.id
  name = "Bastion-Host-SG"
}

#Cracion de la Instancia EC2 para el Bastion
resource "aws_instance" "bastion" {
  ami = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"
  key_name = data.aws_key_pair.vockey.key_name
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [ data.aws_security_group.bastion.id ]
  associate_public_ip_address = true
  tags = {
    Name = "Bastion Host"
  }
}
