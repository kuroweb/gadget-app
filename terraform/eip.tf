#########
#  eip  #
#########
resource "aws_eip" "gadget-ngw-eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.gadget-igw]

  tags = {
    Name = "gadget-ngw-eip"
  }
}
