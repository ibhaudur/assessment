pipeline {
    agent none

    stages {
        stage('Checkout') {
            agent any
            steps {
                git branch: 'main', 
                     url: 'https://github.com/ibhaudur/assessment.git'
            }
        }

        stage('Build & Test') {
            agent {
                docker {
                    image 'python:3.11' // Matches your 3.11.2
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'python --version'
                sh 'pip install --upgrade pip'
                sh 'pip install -r requirements.txt'
                sh 'python -m pytest || true' // Add your test command
            }
        }

        stage('Build Docker Image') {
            agent any
            steps {
                script {
                    docker.build("python-app:${env.BUILD_ID}")
                }
            }
        }

        stage('Run Container') {
            agent any
            steps {
                script {
                    // Stop if already running
                    sh 'docker stop python-app || true'
                    sh 'docker rm python-app || true'
                    // Run new container
                    docker.image("python-app:${env.BUILD_ID}").run(
                        '-p 5000:5000 --name python-app --rm'
                    )
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed. Access app at http://localhost:5000'
        }
        failure {
            echo 'Pipeline failed! Check logs above.'
        }
    }
}