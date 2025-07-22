# EC2 Deployment Automation – DevOps Assignment

## 📌 Purpose
Automates EC2 deployment with stage-based configs (`dev`, `prod`, etc.).

## 🚀 Features
- Launches EC2 instance
- Installs Java 21, Git, Maven
- Clones and builds repo
- Runs app on port 80
- Tests app health
- Stops instance after delay

## 🗂 Folder Structure

project-folder/
├── configs/
│   └── dev_config.env
├── deploy_app.sh
├── launch-ec2.sh
└── README.md
