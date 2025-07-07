#!/bin/bash
# Update & install dependencies
yum update -y
yum install -y python3 git curl

# Install Node.js
curl -sL https://rpm.nodesource.com/setup_14.x | bash -
yum install -y nodejs

# Clone repo
cd /home/ec2-user
git clone https://github.com/YOUR_USERNAME/your-flask-express-repo.git app
cd app

# Flask Setup
cd flask-backend
pip3 install -r requirements.txt
nohup python3 app.py &

# Express Setup
cd ../express-frontend
npm install
nohup npm start &
