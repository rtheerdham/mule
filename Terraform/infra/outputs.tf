output "id1" {
  description = "The id of the provisioned VPC"
  value       = aws_vpc.vpc1.id
}

output "id2" {
  description = "The id of the provisioned VPC"
  value       = aws_vpc.vpc2.id
}

output "subnet1" {
  description = "A list of the public subnets under the provisioned VPC"
  value       = aws_subnet.subnet1.*.id
}

output "subnet2" {
  description = "A list of the public subnets under the provisioned VPC"
  value       = aws_subnet.subnet2.*.id
}