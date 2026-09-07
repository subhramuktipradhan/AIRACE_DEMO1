
pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                bat '.\\gradlew.bat clean build'
            }
        }

        stage('Test') {
            steps {
                bat '.\\gradlew.bat test'
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build -t subhramukti/image2:latest .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    bat 'echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin'
                    bat 'docker push subhramukti/image2:latest'
                }
            }
        }
    }

    post {
        success {
            echo 'Build, tests, Docker image build and Docker Hub push completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}

