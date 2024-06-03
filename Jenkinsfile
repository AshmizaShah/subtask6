pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker'
        DOCKER_IMAGE = 'ashmizashah/docker:latest'
        GIT_REPOSITORY = 'https://github.com/AshmizaShah/subtask6.git'
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
        stage('Send Email Notification') {
            steps {
                script {
                    sendEmailNotification()
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

def sendEmailNotification() {
    def buildStatus = currentBuild.currentResult
    def subject = buildStatus == 'SUCCESS' ? "Jenkins Build Success: ${env.JOB_NAME} #${env.BUILD_NUMBER}" : "Jenkins Build Failure: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
    def body = buildStatus == 'SUCCESS' ? "Good news! The Jenkins build for ${env.JOB_NAME} #${env.BUILD_NUMBER} has succeeded.\n\nCheck the details here: ${env.BUILD_URL}" : "Unfortunately, the Jenkins build for ${env.JOB_NAME} #${env.BUILD_NUMBER} has failed.\n\nCheck the details here: ${env.BUILD_URL}"
    
    emailext(
        subject: subject,
        body: body,
        recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']]
    )
}
