##############
# RouteTable #
##############
resource "aws_route_table" "gadget-public-rtb" {
  vpc_id = aws_vpc.gadget-vpc.id

  route {
    gateway_id = aws_internet_gateway.gadget-igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "gadget-public-route"
  }
}
resource "aws_route_table" "gadget-private-rtb" {
  vpc_id = aws_vpc.gadget-vpc.id

  route {
    nat_gateway_id = aws_nat_gateway.gadget-ngw.id
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    Name = "gadget-private-route"
  }
}

###############
# association #
###############
resource "aws_route_table_association" "gadget-public-rtb-1a" {
  subnet_id      = aws_subnet.gadget-public-1a.id
  route_table_id = aws_route_table.gadget-public-rtb.id
}
resource "aws_route_table_association" "gadget-public-rtb-1c" {
  subnet_id      = aws_subnet.gadget-public-1c.id
  route_table_id = aws_route_table.gadget-public-rtb.id
}
resource "aws_route_table_association" "gadget-private-rtb-1a" {
  subnet_id      = aws_subnet.gadget-private-1a.id
  route_table_id = aws_route_table.gadget-private-rtb.id
}
resource "aws_route_table_association" "gadget-private-rtb-1c" {
  subnet_id      = aws_subnet.gadget-private-1c.id
  route_table_id = aws_route_table.gadget-private-rtb.id
}
