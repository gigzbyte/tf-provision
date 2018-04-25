
resource "aws_instance" "dmitri-ec2-instance" {
  ami           = "${var.ec2-ami-image}"
  instance_type = "ec2-instance-type"
  associate_public_ip_address = "true"
  subnet_id = "${var.vpc-subnet-id}"
  vpc_security_group_ids = ["${var.ec2-securitygroup}"]
  key_name = "${var.ec2-key-name}"
  tags {
        Name = "${var.ec2-name}"
  }
  user_data = <<HEREDOC
  #!/bin/bash
  /usr/bin/apt-get -y update
  /usr/bin/apt-get -y dist-upgrade
  /usr/bin/apt-get -y install ntp ntpdate htop curl wget zabbix-agent
  /usr/bin/curl https://nginx.org/keys/nginx_signing.key -o /tmp/nginx_signing.key
  /usr/bin/apt-key /tmp/nginx_signing.key
  /usr/bin/apt-get -y update
  /usr/bin/apt-get -y install nginx
HEREDOC
}

