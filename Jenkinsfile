pipeline {
    agent any // Define agent here

    environment {
        registry = "bhavya16/swe645assignment2"
        registryCredential = 'dockerhub'
        dateTag = new Date().format("yyyyMMdd-HHmmss") // Define dateTag in environment block
    }

    stages {
        stage('Building docker image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        def img = docker.build("bhavya16/swe645assignment2:${dateTag}")
                    }
                }
            }
        }
        stage('Publishing code to latest code to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        def image = docker.build("bhavya16/swe645assignment2:${dateTag}", '. --no-cache')
                        image.push()
                    }
                }
            }
        }
        stage('Deploying to single node in Rancher') {
            steps {
                script {
                    sh "kubectl set image deployment/deploy cointainer-0=bhavya16/swe645assignment2:${dateTag}"
                    sh "kubectl set image deployment/deployloadbalancer cointainer-0=bhavya16/swe645assignment2:${dateTag}"
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
    }
}
