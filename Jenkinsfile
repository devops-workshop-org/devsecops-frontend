pipeline {
    agent any
    
    environment {
        DOCKER_OWNER = 'raniakh'
        DOCKER_USER = 'raniakh'
        DOCKER_TOKEN = credentials('docker-token-raniakh')
        
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
