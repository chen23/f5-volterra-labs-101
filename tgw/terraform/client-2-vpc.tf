
resource "aws_vpc" "client-2-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "${var.prefix}-client-2-vpc"
  }
}

resource "aws_subnet" "client-2-management-1" {
  vpc_id                  = "${aws_vpc.client-2-vpc.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}${var.az1}"

  tags = {
    Name = "${var.prefix}-client-2-management-1"
  }
}

resource "aws_subnet" "client-2-management-2" {
  vpc_id                  = "${aws_vpc.client-2-vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}${var.az2}"

  tags = {
    Name = "${var.prefix}-client-2-management-2"
  }
}

resource "aws_subnet" "client-2-internal-1" {
  vpc_id                  = "${aws_vpc.client-2-vpc.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}${var.az1}"

  tags = {
    Name = "${var.prefix}-client-2-internal-1"
  }
}

resource "aws_subnet" "client-2-internal-2" {
  vpc_id                  = "${aws_vpc.client-2-vpc.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}${var.az2}"

  tags = {
    Name = "${var.prefix}-client-2-internal-2"
  }
}

resource "aws_subnet" "client-2-internal-3" {
  vpc_id                  = "${aws_vpc.client-2-vpc.id}"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}${var.az1}"

  tags = {
    Name = "${var.prefix}-client-2-internal-3"
  }
}

resource "aws_subnet" "client-2-internal-4" {
  vpc_id                  = "${aws_vpc.client-2-vpc.id}"
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}${var.az2}"

  tags = {
    Name = "${var.prefix}-client-2-internal-4"
  }
}





resource "aws_internet_gateway" "client-2-vpc-gw" {
  vpc_id = "${aws_vpc.client-2-vpc.id}"

  tags = {
    Name = "${var.prefix}-client-2-igw"
  }
}

resource "aws_route_table" "client-2-vpc-external-rt" {
  vpc_id = "${aws_vpc.client-2-vpc.id}"

  tags = {
    Name = "${var.prefix}-client-2-external-rt"
  }
}

resource "aws_route" "client-2-gateway" {
  route_table_id         = aws_route_table.client-2-vpc-external-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.client-2-vpc-gw.id}"
  depends_on             = [aws_route_table.client-2-vpc-external-rt]
}

resource "aws_route_table_association" "client-2-management-1" {
  subnet_id      = aws_subnet.client-2-management-1.id
  route_table_id = aws_route_table.client-2-vpc-external-rt.id
}

resource "aws_route_table_association" "client-2-management-2" {
  subnet_id      = aws_subnet.client-2-management-2.id
  route_table_id = aws_route_table.client-2-vpc-external-rt.id
}


resource "aws_security_group" "client-2-vpc" {
  name   = "${var.prefix}-client-2-vpc"
  vpc_id = "${aws_vpc.client-2-vpc.id}"

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
    cidr_blocks = [var.trusted_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
