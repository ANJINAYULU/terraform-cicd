resource "aws_s3_bucket" "example" {
  bucket = "anjisample"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

provider "aws" {
  region = var.aws_region
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnet
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

# Security Group
resource "aws_security_group" "ec2_sg" {
  name        = var.security_group_name
  description = "Allow SSH and HTTP access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_http_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}

# EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = tolist(data.aws_subnet_ids.default.ids)[0]
  key_name      = var.key_pair_name

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  tags = {
    Name = var.instance_name
  }
}










































# # S3 bucket for state
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = var.bucket_name
#   acl    = "private"

#   versioning {
#     enabled = true
#   }

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }

#   lifecycle {
#     prevent_destroy = true
#   }
# }

# # DynamoDB table for state locking
# resource "aws_dynamodb_table" "terraform_locks" {
#   name           = "terraform-locks"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
#