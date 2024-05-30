pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def dockerImage = docker.build('my-app:latest')
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    dockerImage.push('docker.io/ashmizashah/my-app:latest')
                }
            }
        }
    }
}
