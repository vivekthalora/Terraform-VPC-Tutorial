// Jenkinsfile
String credentialsId = 'AWS-Jenkins-Integration'

try {
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

// Run terraform validate
  stage ('Terraform Validate') {
    print "Validating The TF Files"
    sh "cd terraform-project/terraform-templates && /usr/local/bin/terraform validate -var-file=${environment}-secrets.tfvars"
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


