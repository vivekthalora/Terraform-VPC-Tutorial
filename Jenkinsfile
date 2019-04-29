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
catch (caughtError) {
  err = caughtError
  currentBuild.result = "FAILURE"
}

finally {
  /* Must re-throw exception to propagate error */
  if (err) {
    throw err
  }
}


