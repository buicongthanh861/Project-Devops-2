provider "aws" {
  region = "ap-southeast-1"
}

# VPC
resource "aws_vpc" "congthanh_vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "congthanh_vpc"
  }
}





# Subnets
resource "aws_subnet" "congthanh-public-subnet-01" {
  vpc_id                  = aws_vpc.congthanh_vpc.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"
  tags = {
    Name = "congthanh-public-subnet-01"
  }
}

resource "aws_subnet" "congthanh-public-subnet-02" {
  vpc_id                  = aws_vpc.congthanh_vpc.id
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1b"
  tags = {
    Name = "congthanh-public-subnet-02"
  }
}

# Internet Gateway + Route Table
resource "aws_internet_gateway" "congthanh_igw" {
  vpc_id = aws_vpc.congthanh_vpc.id
  tags = {
    Name = "congthanh_igw"
  }
}

resource "aws_route_table" "congthanh-public-rt" {
  vpc_id = aws_vpc.congthanh_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.congthanh_igw.id
  }
}

resource "aws_route_table_association" "congthanh-rta-public-subnet-01" {
  subnet_id      = aws_subnet.congthanh-public-subnet-01.id
  route_table_id = aws_route_table.congthanh-public-rt.id
}

resource "aws_route_table_association" "congthanh-rta-public-subnet-02" {
  subnet_id      = aws_subnet.congthanh-public-subnet-02.id
  route_table_id = aws_route_table.congthanh-public-rt.id
}

# Security group
resource "aws_security_group" "security_group" {
  name        = "security_group"
  description = "Allow SSH, HTTP, and HTTPS traffic"
  vpc_id      = aws_vpc.congthanh_vpc.id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "congthanh-security-group"
  }
}

# EC2 instances
resource "aws_instance" "demo-server" {
  ami                    = "ami-0933f1385008d33c4" # check lại AMI hợp lệ
  instance_type          = "t3.micro"
  key_name               = "congthanh-devops"
  vpc_security_group_ids = [aws_security_group.security_group.id]
  subnet_id              = aws_subnet.congthanh-public-subnet-01.id

  for_each = toset(["jenkins-master", "build-slave", "ansible"])

  tags = {
    Name = each.key
  }
}

#Modules (EKS)
module "sgs" {
  source = "../sg_eks"
  vpc_id = aws_vpc.congthanh_vpc.id
 }

 module "eks" {
   source     = "../eks"
   vpc_id     = aws_vpc.congthanh_vpc.id
   subnet_ids = [
     aws_subnet.congthanh-public-subnet-01.id,
     aws_subnet.congthanh-public-subnet-02.id
   ]
   sg_ids = [module.sgs.security_group_id]
 }