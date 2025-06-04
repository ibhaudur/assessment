FROM jenkins/jenkins:lts

USER root

# Install docker CLI (client only, no daemon)
RUN apt-get update && \
    apt-get install -y docker.io && \
    rm -rf /var/lib/apt/lists/*

USER jenkins
