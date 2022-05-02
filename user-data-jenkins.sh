#! /bin/bash
yum update –y
yum install mysql -y
yum install git -y
yum install docker-y
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin
eksctl version
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade
amazon-linux-extras install java-openjdk11 -y
amazon-linux-extras install epel -y
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
systemctl status jenkins #To check status