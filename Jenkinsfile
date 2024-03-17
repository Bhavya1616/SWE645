pipeline {
    agent any
    
    environment {
        registry = "bhavya16/swe645assignment2"
        registryCredential = 'dockerhub'
        dockerRegistryUrl = "https://index.docker.io/v1/" // Define the Docker registry URL explicitly
        dateTag = new Date().format("yyyyMMdd-HHmmss")
    }
    
    stages {
        stage('Building docker image') {
            steps {
                script {
                    docker.withRegistry("${dockerRegistryUrl}", "${registryCredential}") {
                        def img = docker.build("${registry}:latest")
                    }
                }
            }
        }
        
        stage('Publishing code to Docker Hub') {
            steps {
                script {
                    docker.withRegistry("${dockerRegistryUrl}", "${registryCredential}") {
                        def image = docker.build("${registry}:latest", ". --no-cache")
                        image.push()
                    }
                }
            }
        }
        
        stage('Retrieve latest deployment YAML') {
            steps {
                script {
                    sh 'kubectl get deployment deploynodeport -o yaml > deploynodeport.yaml'
                }
            }
        }
        
        stage('Deploying to single node in Rancher') {
            steps {
                script {
                    sh 'kubectl apply -f deploynodeport.yaml'
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
