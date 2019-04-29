// Jenkinsfile
node("master") {
  String credentialsId = 'AWS-Jenkins-Integration'
  def environment = "Development"
  // Git checkout
  stage('checkout') {
    node {
      cleanWs()
      checkout scm
    }
  }

  // Run terraform init
  stage ('Terraform Init') {
    sh "cd /var/lib/jenkins/workspace/Terraform-VPC_master/ && /usr/local/bin/terraform init"
  }

  // Run terraform plan
  stage ('Terraform Plan') {
    sh "ls /var/lib/jenkins/workspace/Terraform-VPC_master; /usr/local/bin/terraform plan /var/lib/jenkins/workspace/Terraform-VPC_master -var-file=${environment}-secrets.tfvars -out=create.tfplan"
  }

  // Run terraform apply
  //stage ('Terraform Apply') {
  //  sh "ls /var/lib/jenkins/workspace/Terraform-VPC_master; /usr/local/bin/terraform apply /var/lib/jenkins/workspace/Terraform-VPC_master"
  //}
}
