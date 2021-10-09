pipeline {
    agent any

    stages {
        stage ('Install dependencies') {
            steps {
                sh 'docker build -t my-app:1.0 .'
            }
        }
    }
}
