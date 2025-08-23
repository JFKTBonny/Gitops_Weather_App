# VPC
resource "aws_vpc" "gitops_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "gitops-${var.environment}-vpc"
  }
}

# Subnets
resource "aws_subnet" "default_subnet" {
  vpc_id            = aws_vpc.gitops_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name = "gitops-${var.environment}-default-subnet"
  }
}

resource "aws_subnet" "eks_subnet" {
  vpc_id            = aws_vpc.gitops_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name = "gitops-${var.environment}-eks-subnet"
  }
}