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
    ansiColor('xterm') {
      sh "cd /var/lib/jenkins/workspace/Terraform-VPC_master/ && /usr/local/bin/terraform init"
    }
  }

  // Run terraform plan
  stage ('Terraform Plan') {
    ansiColor('xterm') {
      sh "cd /var/lib/jenkins/workspace/Terraform-VPC_master/ && /usr/local/bin/terraform plan"
    }
  }
}
