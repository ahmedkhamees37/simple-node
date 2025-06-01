provider "aws" {
  region = var.region
}

resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "AppServer"
  }
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "AppBucket"
  }
}

resource "aws_s3_bucket_acl" "app_bucket_acl" {
  bucket = aws_s3_bucket.app_bucket.id
  acl    = "private"
}


resource "aws_iam_role" "ec2_s3_access_role" {
  name = "ec2_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.ec2_s3_access_role.name
}

resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "ec2_s3_profile"
  role = aws_iam_role.ec2_s3_access_role.name
}

resource "aws_instance" "app_server" {
  # ... (previous configuration)
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name
}

variable "region" {
  default = "us-west-2"
}

variable "ami_id" {
  default = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "bucket_name" {
  default = "my-app-bucket"
}

output "instance_public_ip" {
  value = aws_instance.app_server.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_bucket.id
}