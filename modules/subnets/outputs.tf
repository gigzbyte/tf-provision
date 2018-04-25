output "subnet_id" {
  value = "${aws_subnet.dmitri-subnet.id}"
}

output "route-association" {
  value = "${aws_route_table_association.dmitri-route-association.id}"
}
