

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Declare the variables
variable "my_access_key" {
  description = "AWS access key"
}

variable "my_secret_key" {
  description = "AWS secret key"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = var.my_access_key
  secret_key = var.my_secret_key
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}


# Create subnets
resource "aws_subnet" "example_subnet1" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
}

resource "aws_subnet" "example_subnet2" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
}

# Create security group
resource "aws_security_group" "example_sg" {
  vpc_id      = aws_vpc.example.id
  name        = "example-security-group"
  description = "Example security group"

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