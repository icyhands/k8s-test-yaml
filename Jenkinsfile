pipeline {
    environment {
        GIT_URL = "https://github.com/icyhands/k8s-test-yaml.git"
        registry = "kett/jen-test"
        dockerImage = ""
        dockerhub = "https://hub.docker.com/repository/docker/kett/jen-test/general"
        dockerhub_credentials = "kett-dockerhub"
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
                    dockerImageLatest = docker.build registry + ":latest"
                }
            }
        }
        stage('push') {
            steps {
                script {
                    docker.withRegistry('', dockerhub_credentials) {
                        dockerImage.push()
                        dockerImageLatest.push()
                        currentBuild.result = 'SUCCESS'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }
    }
}
