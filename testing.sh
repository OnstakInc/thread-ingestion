#!/bin/bash
mkdir /var/testing

cat > /var/testing/ping.sh <<- EOM
#!/bin/bash

systemctl start firewalld

firewall-cmd --zone=public --permanent --add-port=8484/tcp
firewall-cmd --zone=public --permanent --add-port=8080/tcp

firewall-cmd --reload

ipAddress=$(hostname -I)

ping $ipAddress -s 64000 -i 0.1
EOM

chmod +x /var/testing/ping.sh

cat > /etc/systemd/system/dos.service <<- EOM
[Unit]
Description=DOS Service
After=network.target

[Service]
ExecStart=/var/testing/ping.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOM

systemctl daemon-reload
systemctl start dos
