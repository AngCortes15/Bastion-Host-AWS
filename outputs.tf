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

#bastion host instance y sg
output "bastion_instance_id" {
  description = "ID de la instancia EC2 del bastion"
  value = aws_instance.bastion.id
}

output "bastion_public_id" {
  description = "IP publica del Bastion"
  value = aws_instance.bastion.public_ip
}
output "bastion_public_dns" {
  description = "DNS publico del bastion host"
  value = aws_instance.bastion.public_dns
}
output "bastion_sg_id" {
  description = "ID del SG del bastion"
  value = data.aws_security_group.bastion.id
}
output "my_current_ip" {
  description = "Mi ip publica actual"
  value = "${chomp(trimspace(data.http.my_ip.response_body))}/32"
}

#Private Subnet
output "private_subnet_id" {
  description = "Id de la subnet privada"
  value = aws_subnet.private.id
}

output "private_subnet_cidr" {
  description = "CIDR block de la private subnet"
  value = aws_subnet.private.cidr_block
}

output "private_subnet_az" {
  description = "az de la subnet privada"
  value = aws_subnet.private.availability_zone
}

#NAT Gateway
output "nat_gateway_id" {
  description = "ID del NAT_G"
  value = aws_nat_gateway.main.id
}

output "nat_gateway_public_ip" {
  description = "Elastic IP publica del NAT Gateway"
  value = aws_eip.nat.public_ip
}

output "private_route_table_id" {
  description = "ID de la Private Route Table"
  value = aws_route_table.private.id
}

output "nat_gateway_subnet" {
  description = "Subnet donde esta el NAT Gateway"
  value = aws_nat_gateway.main.subnet_id
}

#Private Instance
output "private_instance_id" {
  description = "Id de las intancia privada"
  value = aws_instance.private.id
}

output "private_instance_private_ip" {
  description = "IP privada de la instancia privada"
  value = aws_instance.private.private_ip
}