pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                     git branch: 'main',
                     url: 'https://github.com/ibhaudur/assessment.git'
            }
        }

      stage('Build & Test') {
    agent {
        docker {
            image 'python:3.12'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    steps {
        sh 'python --version'
        sh 'pip install -r requirements.txt'
    }
}

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("assessment:${env.BUILD_ID}")
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    docker.image("assessment:${env.BUILD_ID}").run('-p 5000:5000 --name python-app --rm')
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}