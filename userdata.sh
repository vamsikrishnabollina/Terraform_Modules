#!/bin/bash -x
sudo yum install yum-utils
sudo yum install -y docker
sudo service  docker start
#sudo docker run hello-world
sudo yum update -y
sudo yum install -y java-1.8.0-openjdk.x86_64
sudo cp /etc/profile /etc/profile_backup
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile
sudo yum install -y wget
sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py
sudo pip install awscli
sudo docker volume create jenkins-data
sudo docker pull jenkins
sudo docker run -d -p 8080:8080 -v jenkins-data:/var/jenkins_home --restart always docker.io/jenkins:latest
