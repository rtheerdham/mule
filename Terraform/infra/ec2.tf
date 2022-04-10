data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "template_file1" "user_data1" {
  template = file("user_data1.tpl")
}

data "template_file2" "user_data2" {
  template = file("user_data2.tpl")
}

resource "aws_key_pair" "deployer" {
  key_name   = "mykey"
  public_key = "ssh-rsa AAAAB3NzaC1y..."
}

resource "aws_instance" "mule-api" {
  ami                         = "ami-0a91cd140a1fc148a"
  instance_type               = "t2.large"
  subnet_id                   = aws_subnet.subnet1.id
  user_data                   = data.template_file1.user_data1.template
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = "true"
  tags = {
    Name = "mule-api"
  }
}

resource "aws_instance" "mule-db" {
  ami                         = "ami-0a91cd140a1fc148a"
  instance_type               = "t2.small"
  subnet_id                   = aws_subnet.subnet2.id
  user_data                   = data.template_file2.user_data2.template
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = "true"
  tags = {
    Name = "rds"
  }
}

resource "aws_security_group" "api_sg" {
  name        = "allow_ssh"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "ds_sg" {
  name        = "allow_mysql"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc2.id

  ingress {
    description = "SSH from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = [var.subnet1_cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_mysql"
  }
}