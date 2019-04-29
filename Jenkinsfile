// Jenkinsfile
node("master") {
  String credentialsId = 'AWS-Jenkins-Integration'

  // Git checkout
  stage('checkout') {
    node {
      cleanWs()
      checkout scm
    }
  }

  // Run terraform init
  stage ('Terraform Init') {
    print "Init Provider"
    sh "cd Terraform-VPC_master/ && /usr/local/bin/terraform init"
  }
}
