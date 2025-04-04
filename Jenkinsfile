pipeline {
    agent any

    stages {
        stage('SCM Checkout') {
            steps {
                git branch: 'main', credentialsId: 'githubapp', url: 'https://github.com/unjilani/capstoneproject.git'
            }
        }
    }
}