// Jenkinsfile
node("master") {
  String credentialsId = 'AWS-Jenkins-Integration'
  def environment = "Development"
  // Git checkout
  stage('checkout') {
    node {
      checkout scm
    }
  }

  // Run terraform init
  stage ('Terraform Init') {
    sh "cd /var/lib/jenkins/workspace/Terraform-VPC_master && /usr/local/bin/terraform init"
  }

  // Run terraform plan
  //stage ('Terraform Plan') {
  //  sh "/usr/local/bin/terraform plan -out=create.tfplan /var/lib/jenkins/workspace/Terraform-VPC_master/"
  //}

  // Run terraform apply
  //stage ('Terraform Apply') {
  //  sh "ls /var/lib/jenkins/workspace/Terraform-VPC_master; /usr/local/bin/terraform apply /var/lib/jenkins/workspace/Terraform-VPC_master"
  //}
}
