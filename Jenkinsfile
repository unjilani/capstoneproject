pipeline {
    agent any

    environment {
        IMAGE_NAME = "nginx"
        TAG = "latest"
        REMOTE_SERVER = "ec2-user@3.135.220.61"
        PORT = "8080"
    }

    stages {
        stage('Clone Repository') {
            steps {
                script{
				git branch: 'main', credentialsId: 'githubapp', url: 'https://github.com/unjilani/capstoneproject.git'
               }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t $IMAGE_NAME:$TAG -f dockerfile .
                '''
            }
        }

        stage('Deploy to Server') {
            steps {
                    sh """
                    docker run -d --name ${IMAGE_NAME} -p ${PORT}:${PORT} ${IMAGE_NAME}:${TAG}
                    """
                }
            }
    }

    post {
        success {
            echo '🎉 Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed.'
        }
    }
}