output "vpc_natgw-eip-id" {
  value = "${aws_eip.dmitri-natgw-eip.id}"
}

output "natgw-id" {
  value = "${aws_nat_gateway.dmitri-natgw.id}"
}

