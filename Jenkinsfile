pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials') // Jenkins credentials ID
        DOCKER_IMAGE = 'ashmizashah/docker' // Docker Hub repository name
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/AshmizaShah/subtask6.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push('latest')
                    }
                }
            }
        }

        stage('Deploy to Testing Environment') {
            steps {
                script {
                    // Stop and remove any existing container with the same name
                    sh 'docker stop my-python-app || true && docker rm my-python-app || true'
                    
                    // Run the new container
                    sh 'docker run -d -p 80:80 --name my-python-app ashmizashah/docker:latest'
                }
            }
        }
    }
}
