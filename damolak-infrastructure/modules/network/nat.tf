resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.environment}-nat-eip"
  }
}

 

resource "aws_nat_gateway" "nat" {
  allocation_id = var.eip_allocation_id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.environment}-nat"
  }

  depends_on = [aws_internet_gateway.igw]

  lifecycle {
    prevent_destroy = false
  }
  
}