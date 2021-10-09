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
                    
                       
                        docker login -u ${env.DOCKER_USER} -p ${env.DOCKER_TOKEN}
                        docker build -f Dockerfile -t ${env.DOCKER_OWNER}/angular-app:${env.BUILD_NUMBER} .
                        docker push ${env.DOCKER_OWNER}/angular-app:${env.BUILD_NUMBER}
                        docker tag ${env.DOCKER_OWNER}/angular-app:${env.BUILD_NUMBER} ${env.DOCKER_OWNER}/angular-app:latest
                        docker push ${env.DOCKER_OWNER}/angular-app:latest
                    
                    """.stripIndent()
                )
            }
        }
       
       
    }
}
