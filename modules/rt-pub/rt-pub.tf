resource "aws_route_table" "dmitri-route-table-pub" {
  vpc_id = "${var.vpc-id}"
  tags {
      Name = "${var.vpc-pub-route-table-name}"
  }
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${var.vpc-igw-id}"
    }
}

