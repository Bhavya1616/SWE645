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
                
        stage('Deploying to single node in Rancher') {
            steps {
                script {
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f nodeport.yaml'
                    sh 'kubectl rollout restart deployment/deployment'
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
