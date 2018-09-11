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



cat > /var/testing/fileaccess.sh <<- EOM
#!/bin/bash

while true
do
 	echo $(date +%b_%d_%Y_%H_%M_%S)
    date +%b_%d_%Y_%H_%M_%S >> /var/testing/secretfile
    sleep 6
done


watch -n 6 date +%b_%d_%Y_%H_%M_%S >> /var/testing/secretfile
EOM

chmod +x /var/testing/fileaccess.sh

cat > /etc/systemd/system/fileaccess.service <<- EOM
[Unit]
Description=File Access Service
After=network.target

[Service]
ExecStart=/var/testing/fileaccess.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOM

systemctl daemon-reload
systemctl start fileaccess

systemctl restart tet-sensor
