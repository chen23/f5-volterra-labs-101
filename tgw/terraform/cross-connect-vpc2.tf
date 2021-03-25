resource "aws_vpc" "cross-connect-2-vpc" {
  cidr_block           = "192.168.16.0/20"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "${var.prefix}-cross-connect-2-vpc"
  }
}

resource "aws_subnet" "cross-connect-2-external-1" {
  vpc_id                  = "${aws_vpc.cross-connect-2-vpc.id}"
  cidr_block              = "192.168.16.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}${var.az1}"

  tags = {
    Name = "${var.prefix}-cross-connect-2-external-1"
  }
}

resource "aws_subnet" "cross-connect-2-internal-1" {
  vpc_id                  = "${aws_vpc.cross-connect-2-vpc.id}"
  cidr_block              = "192.168.17.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}${var.az1}"

  tags = {
    Name = "${var.prefix}-cross-connect-2-internal-1"
  }
}

resource "aws_subnet" "cross-connect-2-workload-1" {
  vpc_id                  = "${aws_vpc.cross-connect-2-vpc.id}"
  cidr_block              = "192.168.18.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}${var.az1}"

  tags = {
    Name = "${var.prefix}-cross-connect-2-workload-1"
  }
}

resource "aws_internet_gateway" "cross-connect-2-vpc-gw" {
  vpc_id = "${aws_vpc.cross-connect-2-vpc.id}"

  tags = {
    Name = "${var.prefix}-cross-connect-2-igw"
  }
}

resource "aws_route_table" "cross-connect-2-vpc-external-rt" {
  vpc_id = "${aws_vpc.cross-connect-2-vpc.id}"

  tags = {
    Name = "${var.prefix}-cross-connect-external-rt"
  }
}

resource "aws_route" "cross-connect-2-gateway" {
  route_table_id         = aws_route_table.cross-connect-2-vpc-external-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.cross-connect-2-vpc-gw.id}"
  depends_on             = [aws_route_table.cross-connect-2-vpc-external-rt]
}

resource "aws_route" "cross-connect-1" {
  route_table_id = aws_route_table.cross-connect-2-vpc-external-rt.id
  destination_cidr_block = "192.168.0.0/20"
  vpc_peering_connection_id = aws_vpc_peering_connection.cross-connect.id
}

resource "aws_route" "to-client-2" {
  route_table_id = aws_route_table.cross-connect-2-vpc-external-rt.id
  destination_cidr_block = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.client-2.id
}



resource "aws_route_table_association" "cross-connect-2-external-1" {
  subnet_id      = aws_subnet.cross-connect-2-external-1.id
  route_table_id = aws_route_table.cross-connect-2-vpc-external-rt.id
}




resource "aws_security_group" "cross-connect-2-vpc" {
  name   = "${var.prefix}-cross-connect-2=vpc"
  vpc_id = "${aws_vpc.cross-connect-2-vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.0.0/16"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.trusted_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
