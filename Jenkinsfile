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
                    // Use the specified Docker registry and credentials
                    docker.withRegistry('https://registry.hub.docker.com', 'docker') {
                        // Push the Docker image to Docker Hub
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }
}
