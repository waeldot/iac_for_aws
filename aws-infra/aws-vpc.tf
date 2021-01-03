resource "aws_vpc" "ggr_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "ggr_vpc"
  }
}

resource "aws_internet_gateway" "ggr_igw" {
  vpc_id = aws_vpc.ggr_vpc.id
  tags = {
    Name = "ggr_igw"
  }
}

resource "aws_default_route_table" "ggr_rtb" {
  default_route_table_id = aws_vpc.ggr_vpc.default_route_table_id
  tags = {
    Name = "ggr_rtb"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ggr_igw.id
  }
}

resource "aws_default_security_group" "ggr_secgrp1" {
  vpc_id      = aws_vpc.ggr_vpc.id
  tags = {
    Name = "ggr_secgrp1"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "ggr_subnet1" {
  vpc_id     = aws_vpc.ggr_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ggr_subnet1"
    "kubernetes.io/cluster/ggr_eks" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "ggr_subnet2" {
  vpc_id     = aws_vpc.ggr_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "ggr_subnet2"
    "kubernetes.io/cluster/ggr_eks" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
  
}
