pipeline {
    agent none

    stages {
        // Stage 1: Checkout code
        stage('Checkout') {
            agent any
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[url: 'https://github.com/ibhaudur/assessment.git']]
                ])
            }
        }

        // Stage 2: Build and Test in Python container
        stage('Build & Test') {
            agent {
                docker {
                    image 'python:3.11'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'python --version'
                sh 'pip install -r requirements.txt'
                sh 'python app.py & sleep 5' // Simple test
            }
        }

        // Stage 3: Build Docker image
        stage('Build Image') {
            agent any
            steps {
                script {
                    docker.build("python-app:${env.BUILD_ID}")
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed'
        }
    }
}