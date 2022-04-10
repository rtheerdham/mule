### Network

# VPC1
resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc1_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "${var.environment}_vpc1"
  }
}

# Subnets associated with VPC1
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = element(var.subnet1_cidr_blocks, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  count                   = 3

  tags = {
    Name = "${var.environment}_subnet1_${substr(element(var.availability_zones, count.index), -1, 1)}"
  }
}

# Internet Gateway for VPC1
resource "aws_internet_gateway" "internet_gw1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "${var.environment}_internet_gw1"
  }
}

# route tables for VPC1
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw1.id
  }

  tags = {
    Name = "${var.environment}_rt1"
  }
}


# subnet route table associations for VPC1's route table
resource "aws_route_table_association" "rta1" {
  subnet_id      = element(aws_subnet.subnet1.*.id, count.index)
  route_table_id = aws_route_table.rt1.id
  count          = length(aws_subnet.subnet1)
}


# VPC2
resource "aws_vpc" "vpc2" {
  cidr_block           = var.vpc2_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "${var.environment}_vpc2"
  }
}

# Subnets associated with VPC2
resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = element(var.subnet2_cidr_blocks, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  count                   = 3

  tags = {
    Name = "${var.environment}_subnet2_${substr(element(var.availability_zones, count.index), -1, 1)}"
  }
}

# Internet Gateway for VPC2
resource "aws_internet_gateway" "internet_gw2" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "${var.environment}_internet_gw2"
  }
}

# route tables for VPC2
resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw2.id
  }

  tags = {
    Name = "${var.environment}_rt2"
  }
}


# subnet route table associations for VPC2's route table
resource "aws_route_table_association" "rta2" {
  subnet_id      = element(aws_subnet.subnet2.*.id, count.index)
  route_table_id = aws_route_table.rt2.id
  count          = length(aws_subnet.subnet2)
}

# VPC peering between vpc1 and vpc2
resource "aws_vpc_peering_connection" "peering" {
  peer_vpc_id   = aws_vpc.vpc2.id
  vpc_id        = aws_vpc.vpc1.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

# Create a route 1
resource "aws_route" "r1" {
  route_table_id            = aws_route_table.rt1.id
  destination_cidr_block    = var.vpc2_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

# Create a route 2
resource "aws_route" "r2" {
  route_table_id            = aws_route_table.rt2.id
  destination_cidr_block    = var.vpc1_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}
