pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials') // Jenkins credentials ID for Docker Hub
        DOCKER_IMAGE = 'ashmizashah/docker' // Docker Hub repository name
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                git 'https://github.com/AshmizaShah/subtask6.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the repository
                    def image = docker.build("${env.DOCKER_IMAGE}:${env.BUILD_ID}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login to Docker Hub and push the Docker image
                    docker.withRegistry('https://index.docker.io/v1/', env.DOCKER_HUB_CREDENTIALS) {
                        def image = docker.image("${env.DOCKER_IMAGE}:${env.BUILD_ID}")
                        image.push('latest')
                        image.push("${env.BUILD_ID}")
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

    post {
        always {
            // Clean up any remaining Docker images to save space
            script {
                sh 'docker rmi $(docker images -q ${env.DOCKER_IMAGE}) || true'
            }
        }
    }
}
