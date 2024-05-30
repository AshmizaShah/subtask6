# Use the official Jenkins image from the Docker Hub
FROM jenkins/jenkins:latest

# Install necessary plugins if needed
# Example:
#RUN /usr/local/bin/install-plugins.sh docker-plugin github-plugin

# Copy the Jenkinsfile into the container
COPY Jenkinsfile /usr/share/jenkins/ref/Jenkinsfile
