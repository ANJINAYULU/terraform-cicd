# variable "bucket_name" {
#   type        = string
#   description = "backend bucket name"
#   default     = "terraform-state-anji"
# }

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "terraform-ec2"
}

variable "key_pair_name" {
  description = "Existing AWS Key Pair name"
  type        = string
}

variable "security_group_name" {
  description = "Security group name"
  type        = string
  default     = "terraform-ec2-sg"
}

variable "allowed_ssh_cidr" {
  description = "Allowed CIDR blocks for SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_http_cidr" {
  description = "Allowed CIDR blocks for HTTP"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}







