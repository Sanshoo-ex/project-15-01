provider "aws" {
    region = "ap-south-1"
    access_key = 
    secret_key = 
  
}

resource "aws_vpc" "my_demo_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      Name = "project_vpc01"
    }
}

resource "aws_subnet" "my_demo_SB01" {
    vpc_id = aws_vpc.my_demo_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = ap-south-1a
    map_public_ip_on_launch = true

    tags = {
      Name = "my-Subnet-1"
    }

}

resource "aws_subnet" "my_demo_SB02"{
    vpc_id = aws_vpc.my_demo_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = ap-south-1b
    map_public_ip_on_launch = true

    tags = {
      Name = "my-Subnet-2"
}
}
# cretating internet GW
resource "aws_internet_gateway" "myigw" {
    vpc_id = "aws_vpc.my_demo_vpc.id"
    tags = {
      Name = "MyIGW"
    }
}

#creating route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_demo_vpc.id 
  tags = {
    Name = "route_table-custom"
  }
}


#creating the route
resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.myigw.id
}

#creating the route association
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id = aws_subnet.my_demo_SB01.id
  route_table_id = aws_route_table.public_route_table.id
}