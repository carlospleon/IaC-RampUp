#!/bin/bash
sudo yum update -y
sudo yum install git -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo systemctl start docker
sudo usermod -a -G docker ec2-user
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install node
npm install express
git clone https://github.com/carlospleon/movie-analyst-ui.git
docker pull carlospleon/frontend:v1
docker run -d -p 80:3030 -e BACKEND_URL=10.0.3.173:3000 -e PORT=3030  carlospleon/frontend:v1