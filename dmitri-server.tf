
variable "VPC-name" {
  default = "RND-TF"
  description = "VPC Name"
}

variable "instance_ami" {
  default = ""
  description = "Instance AMI"
}

variable "instance_type" {
  default = "t2.nano"
  description = "DInstance type"
}

variable "instance_name" {
  default = "dmitrisrv.local"
  description = "Instance name"
}

variable "key_name" {
  default = "DLoktev"
  description = "SSH key"
}

variable "vpc-fullcidr" {
  default = "172.16.99.0/24"
  description = "VPC CIDR"
}
variable "Subnet-Public-AzA-CIDR" {
  default = "172.16.99.0/26"
  description = "Public Subnet AZ A"
}

variable "Subnet-Public-AzB-CIDR" {
  default = "172.16.99.64/26"
  description = "Public Subnet AZ B"
}
variable "Subnet-Private-AzA-CIDR" {
  default = "172.16.99.128/26"
  description = "Private Subnet AZ A"
}
variable "Subnet-Private-AzB-CIDR" {
  default = "172.16.99.192/26"
  description = "Private Subnet AZ B"
}

##############################################################

module "dmitri-vpc" {
  source = "modules/vpc"
  vpc-cidr = "${var.vpc-fullcidr}"
  name = "${var.VPC-name}"
}

##############################################################

module "dmitri-igw" {
  source = "modules/igw"
  vpc-id = "${module.dmitri-vpc.vpc_id}"
  vpc-name = "${var.VPC-name}-IGW" 
}

##############################################################

module "dmitri-natgw-a" {
  source = "modules/natgw"
  vpc-subnet-id = "${module.dmitri-subnet-PUB-A.subnet_id}"
  vpc-igw-id = "${module.dmitri-igw.igw_id}-NATGW-A"
}
module "dmitri-natgw-b" {
  source = "modules/natgw"
  vpc-subnet-id = "${module.dmitri-subnet-PUB-B.subnet_id}"
  vpc-igw-id = "${module.dmitri-igw.igw_id}-NATGW-B"
}

##############################################################

module "dmitri-rt-pub-a" {
  source = "modules/rt-pub"
  vpc-id = "${module.dmitri-vpc.vpc_id}"
  vpc-pub-route-table-name = "${var.VPC-name}-PUB-A"
  vpc-igw-id = "${module.dmitri-igw.igw_id}"
}
module "dmitri-rt-pub-b" {
  source = "modules/rt-pub"
  vpc-id = "${module.dmitri-vpc.vpc_id}"
  vpc-pub-route-table-name = "${var.VPC-name}-PUB-B"
  vpc-igw-id = "${module.dmitri-igw.igw_id}"
}

module "dmitri-rt-priv-a" {
  source = "modules/rt-priv"
  vpc-id = "${module.dmitri-vpc.vpc_id}"
  vpc-priv-route-table-name = "${var.VPC-name}-PRIV-A"
  vpc-natgw-id = "${module.dmitri-natgw-a.natgw-id}"
}
module "dmitri-rt-priv-b" {
  source = "modules/rt-priv"
  vpc-id = "${module.dmitri-vpc.vpc_id}"
  vpc-priv-route-table-name = "${var.VPC-name}-PRIV-B"
  vpc-natgw-id = "${module.dmitri-natgw-b.natgw-id}"
}

##############################################################

module "dmitri-subnet-PUB-A" {
  source = "modules/subnets"
  vpc-id = "${module.dmitri-vpc.vpc_id}"
  vpc-name = "${var.VPC-name}-PUB-A"
  vpc-subnet-cidr = "${var.Subnet-Public-AzA-CIDR}"
  vpc-route-table-id = "${module.dmitri-rt-pub-a.vpc-route-table-id}"
}

module "dmitri-subnet-PUB-B" {
  source = "modules/subnets"
  vpc-id = "${module.dmitri-vpc.vpc_id}"
  vpc-name = "${var.VPC-name}-PUB-B"
  vpc-subnet-cidr = "${var.Subnet-Public-AzB-CIDR}"
  vpc-route-table-id = "${module.dmitri-rt-pub-b.vpc-route-table-id}"
}

module "dmitri-subnet-PRIV-A" {
  source = "modules/subnets"
  vpc-id = "${module.dmitri-vpc.vpc_id}"
  vpc-name = "${var.VPC-name}-PRIV-A"
  vpc-subnet-cidr = "${var.Subnet-Private-AzA-CIDR}"
  vpc-route-table-id = "${module.dmitri-rt-priv-a.vpc-route-table-id}"
}

module "dmitri-subnet-PRIV-B" {
  source = "modules/subnets"
  vpc-id = "${module.dmitri-vpc.vpc_id}"
  vpc-name = "${var.VPC-name}-PRIV-B"
  vpc-subnet-cidr = "${var.Subnet-Private-AzB-CIDR}"
  vpc-route-table-id = "${module.dmitri-rt-priv-b.vpc-route-table-id}"
}

##############################################################

module "dmitri-securitygroup" {
  source = "modules/securitygroups"
  vpc-name = "${var.VPC-name}-SG"
  vpc-id = "${module.dmitri-vpc.vpc_id}"
}

module "dmitri-firstserver" {
  source = "modules/ec2"
  vpc-id = "${module.dmitri-vpc.vpc_id}"
  vpc-name = "${var.VPC-name}"
  vpc-subnet-id = "${module.dmitri-subnet-PUB-B.subnet_id}"
  ec2-key-name = "${var.key_name}"
  ec2-ami-image = "${var.instance_ami}"
  ec2-instance-type = "${var.instance_type}"
  ec2-securitygroup = "${module.dmitri-securitygroup.securitygroup_id}"
  ec2-name = "${var.instance_name}"
}