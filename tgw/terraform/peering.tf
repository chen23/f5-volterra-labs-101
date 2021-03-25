resource "aws_vpc_peering_connection" "client-1" {
  peer_vpc_id   = aws_vpc.client-1-vpc.id
  vpc_id        = aws_vpc.cross-connect-1-vpc.id
  auto_accept   = true
}

resource "aws_vpc_peering_connection" "client-2" {
  peer_vpc_id   = aws_vpc.client-2-vpc.id
  vpc_id        = aws_vpc.cross-connect-2-vpc.id
  auto_accept   = true
}

resource "aws_vpc_peering_connection" "cross-connect" {
  peer_vpc_id   = aws_vpc.cross-connect-1-vpc.id
  vpc_id        = aws_vpc.cross-connect-2-vpc.id
  auto_accept   = true
}