#!/bin/bash

apt-get install ca-certificates
apt-get install curl
apt-get install gnupg -y
apt-get install lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
adduser admin docker


docker pull webdevops/php-apache:latest
docker pull mariadb
docker run -d -p 8080:80 --name login webdevops/php-apache:latest
docker run -d -p 8081:80 --name registro webdevops/php-apache:latest
#docker run --name mariadb -e MYSQL_ALLOW_EMPTY_PASSWORD=true -d -p 3306:3306 mariadb:latest
docker container run --name mariadb -e MYSQL_ROOT_PASSWORD=12345 -e MYSQL_USER=joni -e MYSQL_PASSWORD=12345 -e MYSQL_DATABASE=jonibase -p 3307:3306 -d mariadb:10 &>/dev/null


docker exec mariadb apt update
docker exec mariadb apt -y upgrade
docker exec mariadb apt -y install git
docker exec mariadb git clone https://github.com/jonisiito/dbbb /home
docker exec mariadb mysql -u root -p12345 -e "CREATE DATABASE jonibase;"
docker exec mariadb /bin/bash -c "cd /home && mysql -u root -h 172.17.0.4 -p12345 jonibase < jonibase.sql"


docker exec registro apt update 
docker exec registro apt –y upgrade
docker exec registro apt -y install git
docker exec registro git clone https://github.com/jonisiito/register /app


docker exec login apt update 
docker exec login apt –y upgrade
docker exec login apt -y install git
docker exec login git clone https://github.com/jonisiito/logg /app

clear

apt-get install python3-flask -y
apt install sysstat -y
apt install python3-pip -y
cd
git clone https://github.com/jonisiito/monitor /home/admin/monitor
cd /home/admin/monitor
mkdir templates
git clone https://github.com/jonisiito/monitortemplates /home/admin/monitor/templates
cd /home/admin/monitor
python3 app.py

#------FIN------
