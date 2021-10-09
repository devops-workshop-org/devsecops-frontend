pipeline {
    agent any
    
    environment {
        DOCKER_OWNER = 'raniakh'
        DOCKER_USER = 'raniakh'
        DOCKER_TOKEN = credentials('docker-token-raniakh')
        FRONT_IMG_TAG = sh( returnStdout:true,
                    script: 'sha256sum package.json | cut -c1-15'
                  ).trim()
        
        REPO_API_URL = 'https://registry.hub.docker.com/v2/repositories'
    }
    
    stages {
        stage ('Preparing base image for front end') {
            steps {
                sh( returnStdout: false, script: """#!/bin/sh
                    res=\$(wget -O - --user ${env.DOCKER_USER} --password ${env.DOCKER_TOKEN} ${env.REPO_API_URL}/${env.DOCKER_OWNER} | grep ${env.FRONT_IMG_TAG} )
                    if [ -z "\$res" ]; then
                        echo "Did not find image with tag ${env.FRONT_IMG_TAG}"
                        docker login -u ${env.DOCKER_USER} -p ${env.DOCKER_TOKEN}
                        docker build -f Dockerfile -t ${env.DOCKER_OWNER}/angular-front-base:${env.FRONT_IMG_TAG} angular-app/
                        docker push ${env.DOCKER_OWNER}/angular-front-base:${env.FRONT_IMG_TAG}
                    else
                        echo "Found image with tag ${env.FRONT_IMG_TAG}"
                    fi
                    """.stripIndent()
                )
            }
        }
        stage ('Front end image build') {
            steps {
                sh "docker login -u ${env.DOCKER_USER} -p ${env.DOCKER_TOKEN}"
                sh "docker pull ${env.DOCKER_OWNER}/angular-front-base:${env.FRONT_IMG_TAG}"
                sh "docker tag ${env.DOCKER_OWNER}/angular-front-base:${env.FRONT_IMG_TAG} angular-front-base:latest"
                sh "docker build --tag ${env.DOCKER_OWNER}/angular-front:build-${env.BUILD_NUMBER} --file ./angular-app/Dockerfile ./angular-app/"
                sh "docker push ${env.DOCKER_OWNER}/angular-front:build-${env.BUILD_NUMBER}"
                sh "docker tag ${env.DOCKER_OWNER}/angular-front:build-${env.BUILD_NUMBER} ${env.DOCKER_OWNER}/angular-front:latest"
                sh "docker push ${env.DOCKER_OWNER}/angular-front:latest"
            }
        }
     
    
       
    }
}
