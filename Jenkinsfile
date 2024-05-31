pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image and tag it with the appropriate name
                    dockerImage = docker.build('ashmizashah/docker:latest')
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', 'docker') {
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }
}
