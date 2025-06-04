pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ibhaudur/assessment.git'
            }
        }

        stage('Build & Test') {
            steps {
                sh 'python --version'
                sh 'pip install -r requirements.txt'
                sh 'python -m pytest'  # Add tests if needed
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
            // Add Slack/email notification here
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}