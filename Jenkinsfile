// Jenkinsfile
String credentialsId = 'AWS-Jenkins-Integration'

try {
  stage('checkout') {
    node {
      cleanWs()
      checkout scm
    }
  }

  stage ('Terraform Init') {
    print "Init Provider" 
    ansiColor('xterm') {
      sh "cd terraform-project/terraform-templates && /usr/local/bin/terraform init"
    }
  }
}

