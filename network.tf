resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.env}-VPC"
  }
}

resource "aws_internet_gateway" "main" {
    vpc_id  =   aws_vpc.main.id
    tags    =   {
        Name    =   "${var.env}-internet_gw"
    }
}

resource "aws_subnet" "public_subnets" {
    vpc_id                      =   aws_vpc.main.id
    cidr_block                  =   var.public_subnets_cidrs
    map_public_ip_on_launch     =   true
    tags = {
        Name = "${var.env}-public"
    }
}

resource "aws_route_table" "public_subnets" {
    vpc_id  =   aws_vpc.main.id
    route {
        cidr_block   =  "0.0.0.0/0"
        gateway_id   =  aws_internet_gateway.main.id
        }
    tags = {
        Name = "${var.env}-route_public_subnets"
    }

}

resource "aws_route_table_association" "public_routes" {
    count           =   length(aws_subnet.public_subnets[*].id)
    route_table_id  =   aws_route_table.public_subnets.id
    subnet_id       =   element(aws_subnet.public_subnets[*].id, count.index)
}