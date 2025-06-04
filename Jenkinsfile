pipeline {
    agent any

    environment {
        APP_ENV = 'development'
    }

    stages {
        stage('Install & Test') {
            steps {
                script {
                    docker.image('python:3.12').inside {
                        sh 'python --version'
                        sh 'pip install -r requirements.txt'
                        sh 'python app.py'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                sh 'docker build -t python-app .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '▶️ Running Docker container...'
                sh '''
                    docker stop python-app-container || true
                    docker rm python-app-container || true
                    docker run -d --name python-app-container -p 5000:5000 python-app
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Build completed successfully!'
        }
        failure {
            echo '❌ Build failed!'
        }
    }
}
