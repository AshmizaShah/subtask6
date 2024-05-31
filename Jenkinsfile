pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image and assign it to a globally scoped variable
                    dockerImage = docker.build('my-app:latest')
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to the Docker registry
                    dockerImage.push('docker.io/ashmizashah/my-app:latest')
                }
            }
        }
    }
}
