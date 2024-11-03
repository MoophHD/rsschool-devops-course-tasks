// Define a security group for the bastion host:
resource "aws_security_group" "bastion" {
  name        = "bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.bastion_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

// Create an EC2 instance for the bastion host:
resource "aws_instance" "bastion" {
  ami           = "ami-0aa7d40eeae50c9a9" // Amazon Linux 2 AMI in us-east-1; can i define that explicitly?
  instance_type = "t2.micro"
  key_name      = var.bastion_keypair_name

  subnet_id                   = var.public_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion Host"
  }
}

// Allow SSH access from the bastion
resource "aws_security_group" "private_instances" {
  name        = "private-instances-sg"
  description = "Security group for private instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-instances-sg"
  }
}
