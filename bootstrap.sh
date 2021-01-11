#!/bin/bash


apt-get update -y
sudo apt-get install -y software-properties-common dirmngr apt-transport-https
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] https://mirrors.ukfast.co.uk/sites/mariadb/repo/10.5/ubuntu bionic main'
apt-get update -y
apt install -y mariadb-server

rm -Rf /etc/mysql/conf.d/*
cp /Vagrant/files/my.cnf /etc/mysql/conf.d/
chown -R root:root /etc/mysql/conf.d

systemctl restart mariadb

mkdir -p /opt/tools
echo 'PATH=$PATH:/opt/tools' >> /etc/profile
wget -P /opt/tools https://www.percona.com/get/pt-duplicate-key-checker
chmod -R u+x /opt/tools

