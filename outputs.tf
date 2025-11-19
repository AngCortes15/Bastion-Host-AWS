#Subnet Publica
output "vpc_id" {
  description = "ID de la VPC existente que estamos usando"
  value = data.aws_vpc.existing.id
}

output "vpc_name" {
  description = "Nombre de la VPC"
  value = var.vpc_name
}   

output "public_subnet_id" {
  description = "ID de la subnet publica creada"
  value = aws_subnet.public.id
}

output "public_subnet_cidr" {
  description = "CIDR block de la subnet publica"
  value = aws_subnet.public.cidr_block
}

output "public_subnet_az" {
  description = "Zona de disponibilidad de la subnet publica"
  value = aws_subnet.public.availability_zone
}

output "aws_region" {
  description = "Region de AWS que se esta usando"
  value = var.aws_region
}