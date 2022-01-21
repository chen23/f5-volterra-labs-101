data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "f5-jumphost-1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.f5-volterra-management-1.id
  #  private_ip             = "10.0.0.4"
  vpc_security_group_ids = [aws_security_group.volterra-vpc.id]
  key_name               = var.ssh_key
  user_data              = <<-EOF
#!/bin/bash
sleep 30
snap install docker
systemctl enable snap.docker.dockerd
systemctl start snap.docker.dockerd
sleep 30
docker run -d  --net=host --restart=always \
	-e F5DEMO_APP=website \
	-e F5DEMO_NODENAME='Public Endpoint' \
	-e F5DEMO_COLOR=0194d2 \
	-e F5DEMO_NODENAME_SSL='AWS Environment (Backend App)' \
	-e F5DEMO_COLOR_SSL=004892 \
	-e F5DEMO_BRAND=volterra \
	f5devcentral/f5-demo-httpd:nginx
  EOF

  tags = {
    Name = "${var.prefix}-f5-volterra-networking-jumphost-1"
  }
}

