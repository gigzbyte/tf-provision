resource "aws_security_group" "dmitri-sg" {
  name = "${var.vpc-name}"
  tags {
        Name = "${var.vpc-name}"
  }
  description = "Allow EC2 basic traffic in ${var.vpc-name}"
  vpc_id = "${var.vpc-id}"

  ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
