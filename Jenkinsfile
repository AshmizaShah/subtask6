pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker'
        DOCKER_IMAGE = 'ashmizashah/docker:latest'
        GIT_REPOSITORY = 'https://github.com/AshmizaShah/subtask6.git'
        GIT_BRANCH = 'main'
        ANSIBLE_DIR = 'ansible'
        ANSIBLE_PLAYBOOK = 'playbooks/deploy_docker.yml'
        EMAIL_SUBJECT = '${JOB_NAME} - Build #${BUILD_NUMBER} - ${BUILD_STATUS}'
        EMAIL_BODY = 'Job ${JOB_NAME} - Build #${BUILD_NUMBER}\n\n${BUILD_URL}\n\nStatus: ${BUILD_STATUS}'
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
            script {
                // Set build status as an environment variable
                currentBuild.result = currentBuild.currentResult ?: 'SUCCESS'
                env.BUILD_STATUS = currentBuild.result
            }
            // Send email notification
            emailext(
                subject: "${EMAIL_SUBJECT}",
                body: "${EMAIL_BODY}",
                recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                attachLog: true
            )
            cleanWs()
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}

def ansibleDeploy() {
    sh """
        ansible-playbook -i ${ANSIBLE_DIR}/hosts ${ANSIBLE_DIR}/${ANSIBLE_PLAYBOOK} --extra-vars "docker_image=${DOCKER_IMAGE}"
    """
}
