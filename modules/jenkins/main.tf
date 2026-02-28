// Security Group
resource "aws_security_group" "jenkins_sg" {
    name = "jenkins_sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 8081
        to_port = 8081
        protocol = "tcp"
        cidr_blocks = var.allowed_cidr
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.allowed_cidr
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

// AMI Data Source
data "aws_ami" "amazon_linux" {
    most_recent = true

    filter {
        name = "name"
        values = ["*al2023-ami-2023.*.*-kernel-6.1-x86_64*"]
    }

    owners = ["amazon"]
}

// IAM Role
resource "aws_iam_role" "jenkins_role" {
    name = "jenkins_role"

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
            Service = "ec2.amazonaws.com"
        }
    }]
  })
}

// IAM Policy (attach to IAM Role)
resource "aws_iam_role_policy" "jenkins_policy" {
    name = "jenkins_policy"
    role = aws_iam_role.jenkins_role.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect   = "Allow"
            Action   = "*"
            Resource = "*"
        }]
    })
}

// Instance Profile (attach to instance)
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins_profile"
  role = aws_iam_role.jenkins_role.name
}

// EC2 Instance
resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.jenkins_profile.name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = file("${path.module}/install_jenkins.sh")

  tags = {
    Name = "Jenkins"
  }
}