resource "aws_route_table" "dmitri-route-table-priv" {
  vpc_id = "${var.vpc-id}"
  tags {
      Name = "${var.vpc-priv-route-table-name}"
  }
  route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${var.vpc-natgw-id}"
  }
}

