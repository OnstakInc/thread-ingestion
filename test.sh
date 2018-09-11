#!/bin/bash


systemctl start firewalld

firewall-cmd --zone=public --permanent --add-port=8484/tcp
firewall-cmd --zone=public --permanent --add-port=8080/tcp

firewall-cmd --reload


ipAddress=$(hostname -I)

ping $ipAddress -s 64000 -i 0.1
