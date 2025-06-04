pipeline {
    agent any

    environment {
        IMAGE_NAME = 'python-app'
        CONTAINER_NAME = 'python-app-container'
        PORT = '5000'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install & Test') {
            steps {
                echo '🔧 Running Python container for install and test...'
                sh '''
                docker run --rm -v $PWD:/app -w /app python:3.12 sh -c "
                    python --version &&
                    pip install -r requirements.txt &&
                    python app.py
                "
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '🚀 Running Docker container...'
                sh '''
                docker stop $CONTAINER_NAME || true
                docker rm $CONTAINER_NAME || true
                docker run -d --name $CONTAINER_NAME -p $PORT:$PORT $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo '✅ CI/CD pipeline completed successfully!'
        }
        failure {
            echo '❌ CI/CD pipeline failed!'
        }
    }
}
