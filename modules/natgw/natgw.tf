resource "aws_eip" "dmitri-natgw-eip" {
    vpc      = true
}
resource "aws_nat_gateway" "dmitri-natgw" {
    allocation_id = "${aws_eip.dmitri-natgw-eip.id}"
    subnet_id = "${var.vpc-subnet-id}"
    tags {
      Name = "${var.vpc-natgw-name}"
    }
#    depends_on = ["${var.vpc-igw-id}"]
}

