pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "https://hub.docker.com"
        IMAGE_NAME = "ashmizashah/docker"
        TAG_NAME = "latest"
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${TAG_NAME}")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
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
