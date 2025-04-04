pipeline {
    agent any

    environment {
        IMAGE_NAME = "nginx"
        TAG = "latest"
        REMOTE_SERVER = "ec2-user@3.148.145.120"
        PORT = "8080"
    }

    stages {
        stage('Clone Repository') {
            steps {
                script{
                echo 'Building the Criticial Project in progress .............'
				git 'https://github.com/unjilani/capstoneproject.git'  // Replace with your repo
               }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t $IMAGE_NAME:$TAG -f Dockerfile .
                '''
            }
        }

        stage('Save & Transfer Image') {
            steps {
                sh '''
                    docker save -o ${IMAGE_NAME}.tar ${IMAGE_NAME}:${TAG}
                    scp ${IMAGE_NAME}.tar ${REMOTE_SERVER}:/tmp/
                '''
            }
        }

        stage('Deploy to Server') {
            steps {
                sshagent(credentials: ['ec2-user']) {
                    sh """
                        ssh $REMOTE_SERVER '
                            docker load -i /tmp/${IMAGE_NAME}.tar &&
                            docker stop ${IMAGE_NAME} || true &&
                            docker rm ${IMAGE_NAME} || true &&
                            docker run -d --name ${IMAGE_NAME} -p ${PORT}:${PORT} ${IMAGE_NAME}:${TAG}
                        '
                    """
                }
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