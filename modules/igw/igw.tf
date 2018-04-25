resource "aws_internet_gateway" "dmitri-igw" {
   vpc_id = "${var.vpc-id}"
    tags {
        Name = "${var.vpc-name}"
    }
}
