node {
    def buildImage
    def updayName = "artempv/upday-test"

    def helmImage = "alpine/helm"
    def helmChart = "helm/upday-test"
    def helmRelease = "upday-test"

    stage('Clone repository') {
        checkout scm
    }
    stage('Build') { 
        echo 'Starting to build docker image'

        script {
            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                buildImage = docker.build("${updayName}")
                buildImage.push("${env.BUILD_ID}")
                buildImage.push("latest")
            }
        }
    }
    stage('Test') { 
        echo 'Test image'

        //script {
            //app.inside {
                //sh 'echo "Tests passed"'
            //}
        //}
    }
    stage('Deploy') { 
        echo 'Deploy image to kubernetes'

        script {
            withCredentials([file(credentialsId: 'kubernetes', variable: 'kubernetes-admin@kubernetes')]) {
                docker.image("${helmImage}") {
                    sh "helm upgrade --install --debug --set image.repository=${updayName} ${helmRelease} ${helmChart} --kube-context ${kube-context}"
                }
            }
        }
    }
}
