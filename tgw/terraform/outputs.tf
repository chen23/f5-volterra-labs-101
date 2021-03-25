output CLIENT-1_VPC_ID {
  value = aws_vpc.cross-connect-1-vpc.id
}
output CLIENT-1-EXTERNAL_SUBNET_ID {
  value = aws_subnet.cross-connect-1-external-1.id
}

output CLIENT-1-INTERNAL_SUBNET_ID {
  value = aws_subnet.cross-connect-1-internal-1.id
}

output CLIENT-1-WORKLOAD_SUBNET_ID {
  value = aws_subnet.cross-connect-1-workload-1.id
}


output CLIENT-2_VPC_ID {
  value = aws_vpc.cross-connect-2-vpc.id
}
output CLIENT-2-EXTERNAL_SUBNET_ID {
  value = aws_subnet.cross-connect-2-external-1.id
}

output CLIENT-2-INTERNAL_SUBNET_ID {
  value = aws_subnet.cross-connect-2-internal-1.id
}

output CLIENT-2-WORKLOAD_SUBNET_ID {
  value = aws_subnet.cross-connect-2-workload-1.id
}

#output AWS_INSTANCE {
#  value = aws_instance.f5-jumphost-1.public_ip
#}
output PEER {
  value = aws_vpc_peering_connection.cross-connect.id
}