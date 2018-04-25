resource "aws_subnet" "dmitri-subnet" {
  vpc_id = "${var.vpc-id}"
  cidr_block = "${var.vpc-subnet-cidr}"
  tags {
        Name = "${var.vpc-name}"
  }
 availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

resource "aws_route_table_association" "dmitri-route-association" {
    subnet_id = "${aws_subnet.dmitri-subnet.id}"
    route_table_id = "${var.vpc-route-table-id}"
}
