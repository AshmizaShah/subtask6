pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker') // Jenkins credentials ID for Docker Hub
        DOCKER_IMAGE = 'ashmizashah/docker' // Docker Hub repository name
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/AshmizaShah/subtask6.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(env.DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://hub.docker.com/repositories/ashmizashah', DOCKER_HUB_CREDENTIALS) {
                        docker.image(env.DOCKER_IMAGE).push("${env.BUILD_NUMBER}")
                        docker.image(env.DOCKER_IMAGE).push("latest")
                    }
                }
            }
        }

        stage('Deploy to Testing Environment') {
            steps {
                script {
                    // Stop and remove any existing container with the same name
                    sh 'docker stop my-python-app || true && docker rm my-python-app || true'

                    // Run the new container from the latest image
                    sh "docker run -d -p 80:80 --name my-python-app ${env.DOCKER_IMAGE}:latest"
                }
            }
        }
    }
}
