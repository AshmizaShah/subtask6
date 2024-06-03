pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'dockerhub'
        DOCKER_IMAGE = 'ashmizashah/docker:latest'
        GIT_REPOSITORY = 'https://github.com/AshmizaShah/subtask7.git'
        GIT_BRANCH = 'main'
        ANSIBLE_DIR = 'ansible'
        ANSIBLE_PLAYBOOK = 'playbooks/deploy_docker.yml'
    }

    stages {
        stage('Clone Ansible Repo') {
            steps {
                git branch: "${GIT_BRANCH}",
                    url: "${GIT_REPOSITORY}",
                    credentialsId: 'cicd' // Assuming you have credentials configured for Git
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}")
                }
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS}") {
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Deploy with Ansible') {
            steps {
                script {
                    ansibleDeploy()
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

def ansibleDeploy() {
    sh """
        ansible-playbook -i ${ANSIBLE_DIR}/hosts ${ANSIBLE_DIR}/${ANSIBLE_PLAYBOOK} --extra-vars "docker_image=${DOCKER_IMAGE}"
    """
}
