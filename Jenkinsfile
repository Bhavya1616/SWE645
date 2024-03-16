pipeline{
    agent any
    environment{
        registry = "bhavya16/swe645assignment2"
        registryCredential = 'dockerhub'
        def dateTag = new Date().format("yyyyMMdd-HHmmss")
    }
        stages{
            stage('Building docker image'){
                steps{
                    script{
                        docker.withRegistry('',registryCredential){
                            def img = docker.build('bhavya16/swe645assignment2:'+ dateTag)
                        }
                    }
                }
            }
            stage('Publishing code to latest code to Docker Hub'){
                steps{
                    script{
                        docker.withRegistry('',registryCredential){
                            def image = docker.build('bhavya16/swe645assignment2:' + dateTag, '. --no-cache')
                            docker.withRegistry('',registryCredential){
                                image.push()
                            }
                        }
                    }
                }
            }
        stage('Deploying to single node in Rancher'){
    steps{
        script{
            sh 'kubectl apply -f deploynodeport.yaml${dateTag}'
        }
    }
}

        }
    
    post{
        always{
            sh 'docker logout'
        }
    }

}
