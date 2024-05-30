pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "https://hub.docker.com."
        IMAGE_NAME = "ashmizashah/docker"
        TAG_NAME = "latest" // You can use any tag you prefer
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    docker.build("${IMAGE_NAME}:${TAG_NAME}")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    // Push Docker image to registry
                    docker.withRegistry('https://${DOCKER_REGISTRY}', 'docker') {
                        docker.image("${IMAGE_NAME}:${TAG_NAME}").push()
                    }
                }
            }
        }
        
        stage('Deploy to Testing/Staging') {
            steps {
                // Add deployment steps here if needed
            }
        }
    }
}
