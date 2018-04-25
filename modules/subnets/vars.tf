# Declare the data source
data "aws_availability_zones" "available" {}

variable "vpc-id" {}

variable "vpc-name" {}

variable "vpc-subnet-cidr" {}

variable "vpc-route-table-id" {}

