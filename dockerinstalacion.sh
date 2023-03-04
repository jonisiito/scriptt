#!/bin/bash

#instalar docker
apt install git -y
apt-get install ca-certificates
apt-get install curl
apt-get install gnupg -y
apt-get install lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
adduser admin docker

#crear contenedores
docker pull webdevops/php-apache:latest
docker pull mariadb
docker run -d -p 8080:80 --name login webdevops/php-apache:latest
docker run -d -p 8081:80 --name registro webdevops/php-apache:latest
