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
    ansiColor('xterm') {
      sh "cd terraform-project/terraform-templates && /usr/local/bin/terraform init"
    }
  }
}
