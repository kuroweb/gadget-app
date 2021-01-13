##############
# NATGateway #
##############
resource "aws_nat_gateway" "gadget-ngw" {
  allocation_id = aws_eip.gadget-ngw-eip.id
  subnet_id     = aws_subnet.gadget-public-1a.id
  depends_on    = [aws_internet_gateway.gadget-igw]

  tags = {
    Name = "gadget-ngw"
  }
}
