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
sudo `aws ecr get-login --registry-ids 498040579653 --no-include-email --region us-west-1`
sudo docker pull jenkins
sudo docker pull 498040579653.dkr.ecr.us-west-1.amazonaws.com/xtime-napp:west2jenkins
#sudo docker run -d --name ejdapi_1.1 -h ejdapi-01 -e override_db_dot_jdbc_dot_url='jdbc:mysql://chatdbprod.cz8wdk3ouu56.us-west-1.rds.amazonaws.com:3306/chatdbprod?useUnicode=true&characterEncoding=UTF-8'  -e override_db_dot_username=chatdbprod -e override_db_dot_password=chatdb1400 -e override_db_dot_jdbc_dot_driver=com.mysql.jdbc.Driver -e override_db_dot_connection_dot_defaultAutoCommit=true -p 8080:8080 860275329454.dkr.ecr.us-east-1.amazonaws.com/xtime/ejdapi:1.1-20180615-16-08-52
#sudo docker run -d -p 8080:8080 -v jenkins-data:/var/jenkins_home --restart always 498040579653.dkr.ecr.us-west-1.amazonaws.com/xtime-napp:west2jenkins
sudo docker run -d -p 8080:8080 -v jenkins-data:/var/jenkins_home --restart always docker.io/jenkins:latest
