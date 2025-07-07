#!/bin/bash
# Update packages and install Node.js and npm
yum update -y
yum install -y git nodejs npm

# Create project directory
mkdir -p /home/ec2-user/express-app
cd /home/ec2-user/express-app

# Create a basic Express app
cat <<EOF > app.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Hello from Express on its own EC2 instance!');
});

const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => {
    console.log(\`Express app listening on port \${PORT}\`);
});
EOF

# Create package.json and install express
cat <<EOF > package.json
{
  "name": "express-app",
  "version": "1.0.0",
  "main": "app.js",
  "dependencies": {
    "express": "^4.18.2"
  }
}
EOF

npm install

# Run the app in the background
nohup node app.js > express.log 2>&1 &
