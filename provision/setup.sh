#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo "Provisioning virtual machine..."

echo "Installing Git"
apt-get install git -y > /dev/null

echo "Installing Nginx"
apt-get install nginx -y > /dev/null

echo "Configuring Nginx"
cp /vagrant/provision/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost > /dev/null
ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/
rm -rf /etc/nginx/sites-available/default
service nginx restart > /dev/null

echo "Installing Nodejs 4.x"
apt-get install -y python-software-properties python g++ make
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - > /dev/null
apt-get install -y nodejs -y > /dev/null
apt-get install -y build-essential -y > /dev/null
	
echo "Updating NPM"
npm install npm -g -y > /dev/null

echo "Installing supervisor"
npm install -g supervisor -y > /dev/null


echo "Installing MongoDb"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get update -y > /dev/null
apt-get install -y mongodb-org > /dev/null
apt-get install -y mongodb-org=3.2.0 mongodb-org-server=3.2.0 mongodb-org-shell=3.2.0 mongodb-org-mongos=3.2.0 mongodb-org-tools=3.2.0 > /dev/null
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

echo "Configuring MongoDb"
sed -i "s/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g" /etc/mongod.conf
service mongod restart
