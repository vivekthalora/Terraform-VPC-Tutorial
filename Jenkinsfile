// Jenkinsfile
node("master") {
  String credentialsId = 'AWS-Jenkins-Integration'
  def environment = "Development"
  // Git checkout
  stage('checkout') {
    cleanWs()
    checkout scm
  }

  // Run terraform init
  stage ('Terraform Init') {
    sh "cd /var/lib/jenkins/workspace/Terraform-VPC-New_master && /usr/local/bin/terraform init"
  }

  // Run terraform plan
  stage ('Terraform Plan') {
    withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: credentialsId,
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
    ]])
    {
      sh "terraform plan -out=plan.out -no-color"
      //sh "cd /var/lib/jenkins/workspace/Terraform-VPC-New_master && /usr/local/bin/terraform plan -out=create.tfplan"
    }
  }

  // Run terraform apply
  //stage ('Terraform Apply') {
  //  sh "ls /var/lib/jenkins/workspace/Terraform-VPC_master; /usr/local/bin/terraform apply /var/lib/jenkins/workspace/Terraform-VPC_master"
  //}
}
