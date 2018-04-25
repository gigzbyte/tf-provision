resource "aws_vpc" "dmitri_vpc" {
    cidr_block = "${var.vpc-cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags= { 
    	Name = "${var.name}"
    }
}

resource "aws_network_acl" "all" {
   vpc_id = "${aws_vpc.dmitri_vpc.id}"
    egress {
        protocol = "-1"
        rule_no = 2
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "-1"
        rule_no = 1
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    tags {
        Name = "open acl"
    }
}