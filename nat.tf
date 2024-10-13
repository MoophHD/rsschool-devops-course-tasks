// Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  vpc   = true
  count = 1

  tags = {
    Name = "NAT Gateway EIP"
  }
}

// Create a NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id // Place the NAT Gateway in the first public subnet we created previousely

  tags = {
    Name = "Main NAT Gateway"
  }

  depends_on = [aws_internet_gateway.main]
}

// Update the private route table to route traffic through the NAT Gateway
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}
