data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "dmitri-ec2-instance" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.ec2-instance-type}"
  associate_public_ip_address = "true"
  subnet_id = "${var.vpc-subnet-id}"
  vpc_security_group_ids = ["${var.ec2-securitygroup}"]
  key_name = "${var.ec2-key-name}"
  tags {
        Name = "${var.ec2-name}"
  }

  provisioner "file" {
    source="provisioners/ubuntu-bootstrap.sh"
    destination="/tmp/ubuntu-bootstrap.sh"
  }
  provisioner "remote-exec" {
    inline=[
      "chmod +x /tmp/ubuntu-bootstrap.sh",
      "sudo /tmp/ubuntu-bootstrap.sh"
    ]
  }
  connection {
    user="${var.ec2-instance-username}"
    private_key="${file("${var.ec2-instance-key-file}")}"
  }
  
}

