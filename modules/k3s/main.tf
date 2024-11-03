# Security Group for K3s nodes
resource "aws_security_group" "k3s" {
  name        = "k3s-cluster-sg"
  description = "Security group for K3s cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [var.vpd_cidr_block]
  }

  // allow everyvthing from the bastion host
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [var.bastion_sg_id]
  }

  // allow everything from the same security group
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IAM role for EC2 instances
resource "aws_iam_role" "k3s_role" {
  name = "k3s-instance-role"

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

# IAM instance profile
resource "aws_iam_instance_profile" "k3s_profile" {
  name = "k3s-instance-profile"
  role = aws_iam_role.k3s_role.name
}

# K3s server node
resource "aws_instance" "k3s_server" {
  ami           = "ami-0aa7d40eeae50c9a9" // Amazon Linux 2 AMI in us-east-1;
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.k3s.id]
  subnet_id              = var.private_subnet_ids[0]
  iam_instance_profile   = aws_iam_instance_profile.k3s_profile.name
  key_name               = var.bastion_keypair_name

  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | INSTALL_K3S_SKIP_SELINUX_RPM=true sh -s - server \
                --token=${var.k3s_token} \
                --disable-cloud-controller \
                --disable servicelb \
                --write-kubeconfig-mode 644
              EOF

  tags = {
    Name = "k3s-server"
  }
}


# K3s agent node
resource "aws_instance" "k3s_agent" {
  ami           = "ami-0aa7d40eeae50c9a9" # Use an appropriate AMI ID
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.k3s.id]
  subnet_id              = var.private_subnet_ids[1]
  iam_instance_profile   = aws_iam_instance_profile.k3s_profile.name
  key_name               = var.bastion_keypair_name

  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | INSTALL_K3S_SKIP_SELINUX_RPM=true K3S_URL=https://${aws_instance.k3s_server.private_ip}:6443 K3S_TOKEN=${var.k3s_token} sh -
              EOF

  tags = {
    Name = "k3s-agent"
  }
}
