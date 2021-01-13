###################
# InternetGateway #
###################
resource "aws_internet_gateway" "gadget-igw" {
  vpc_id = aws_vpc.gadget-vpc.id

  tags = {
    Name = "gadget-igw"
  }
}
