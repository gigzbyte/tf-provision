# Declare the data source
data "aws_availability_zones" "available" {}

variable "vpc-cidr" {
    description = "VPC CIDR"
}

variable "name" {
	description = "Name of VPC"
}
