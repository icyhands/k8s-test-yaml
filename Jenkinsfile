pipeline {
    environment {
        GIT_URL = "https://github.com/icyhands/k8s-test-yaml.git"
        registry = "kett/web"
        dockerImage = ""
        dockerhub = "https://hub.docker.com/repository/docker/kett/web/general"
        dockerhub_credentials = "kett" #docker credentials ID 작성
    }
    
    agent any

    stages {
        stage('start') {
            steps {
                echo "start jenkins file test"
            }
        }
        stage('pull') {
            steps {
                git url : "${GIT_URL}", branch : "main", poll: true, changelog: true
            }
        }
        stage('build') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('push') {
            steps {
                script {
                    docker.withRegistry('', dockerhub_credentials) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
