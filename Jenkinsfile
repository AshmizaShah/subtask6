pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "ashmizashah/docker"
        DOCKER_REGISTRY = "https://index.docker.io/v1/"
        DOCKER_CREDENTIALS_ID = "this docker hub psswd"
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
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_ID}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry(DOCKER_REGISTRY, DOCKER_CREDENTIALS_ID) {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push('latest')
                    }
                }
            }
        }

        stage('Deploy to Testing Environment') {
            steps {
                sh 'docker run -d -p 80:80 --name my-python-app ${DOCKER_IMAGE}:latest'
            }
        }
    }
}
