resource "aws_key_pair" "k3s" {
  key_name   = "${var.project_name}-k3s-key-${var.environment}"
  public_key = var.ssh_public_key
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "k3s" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id                   = var.private_subnet_ids[0]
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = false
  key_name                   = aws_key_pair.k3s.key_name

  user_data = templatefile("${path.module}/templates/userdata.sh.tpl", {})

  root_block_device {
    volume_size = 50
  }

  tags = {
    Name        = "${var.project_name}-k3s-${var.environment}"
    Environment = var.environment
  }
}