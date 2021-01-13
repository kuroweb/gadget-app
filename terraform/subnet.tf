##########
# Subnet #
##########
resource "aws_subnet" "gadget-public-1a" {
  vpc_id                  = aws_vpc.gadget-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "gadget-public-1a"
  }
}
resource "aws_subnet" "gadget-public-1c" {
  vpc_id                  = aws_vpc.gadget-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "gadget-public-1c"
  }
}
resource "aws_subnet" "gadget-private-1a" {
  vpc_id                  = aws_vpc.gadget-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "gadget-private-1a"
  }
}
resource "aws_subnet" "gadget-private-1c" {
  vpc_id                  = aws_vpc.gadget-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "gadget-private-1c"
  }
}

###############
# SubnetGroup #
###############
resource "aws_db_subnet_group" "gadget-rds-subnet-group" {
  name        = "gadget-rds-subnet-group"
  description = "rds subnet for gadget"
  subnet_ids  = [aws_subnet.gadget-private-1a.id, aws_subnet.gadget-private-1c.id]
}
