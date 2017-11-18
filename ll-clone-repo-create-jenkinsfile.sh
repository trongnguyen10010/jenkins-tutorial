#!/bin/bash

cd ~/
mkdir -p GitHub
cd GitHub

git clone https://github.com/trongnguyen10010/simple-node-js-react-npm-app

cd simple-node-js-react-npm-app/
echo "pipeline {
    agent {
        docker {
            image 'node:6-alpine'
            args '-p 3000:3000'
        }
    }
    environment { 
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deliver') { 
            steps {
                sh './jenkins/scripts/deliver.sh' 
                input message: 'Finished using the web site? (Click "Proceed" to continue)' 
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}" > Jenkinsfile

git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git add .
git commit -m "added jenkinsfile"
