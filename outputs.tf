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

#Internet Gateway
output "igw_name" {
  description = "Nombre del igw"
  value = aws_internet_gateway.main.tags.Name
}

output "igw_id" {
  description = "ID del igw"
  value = aws_internet_gateway.main.id
}

output "igw_arn" {
  description = "arn del igw"
  value = aws_internet_gateway.main.arn
}

output "existing_route_table_id" {
  description = "Id de lo route table asociado a Lab VPC"
  value = data.aws_route_table.existing.id
}

output "internet_route_id" {
  description = "Id de la ruta creada hacia internet"
  value = aws_route.internet_access.id
}