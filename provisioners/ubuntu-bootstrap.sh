#!/bin/bash

/usr/bin/apt-get -y update
/usr/bin/apt-get -y dist-upgrade
/usr/bin/apt-get -y install ntp ntpdate htop curl wget zabbix-agent nginx
