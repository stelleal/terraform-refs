resource "aws_subnet" "app_subnet-1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnets_cidr_blocks[0]
  availability_zone = var.avail_zone[0]
  tags = {
    Name = "${var.project_name}-subnet-1"
  }
}

resource "aws_subnet" "app_subnet-2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnets_cidr_blocks[1]
  availability_zone = var.avail_zone[1]
  tags = {
    Name = "${var.project_name}-subnet-2"
  }
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_default_route_table" "app_default_rtb" {
  default_route_table_id = var.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
  }
  tags = {
    Name = "${var.project_name}-default-rtb"
  }
}