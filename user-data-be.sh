#!/bin/bash
yum update -y
yum install git -y
yum install mysql -y
amazon-linux-extras install docker -y 
service docker start
systemctl enable docker.service
systemctl enable containerd.service
systemctl start docker
usermod -a -G docker ec2-user
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install node -y 
npm install express -y
git clone https://github.com/carlospleon/movie-analyst-api.git
docker pull carlospleon/backend:v1
#docker run -d -p 3000:3000 -e APP_PORT=3000 -e DB_HOST=10.0.1.53 -e DB_USER=Admin -e DB_PASS=password -e DB_NAME=movie_db carlospleon/backend:v1