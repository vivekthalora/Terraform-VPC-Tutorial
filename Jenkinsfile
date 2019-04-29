// Jenkinsfile
node("master") {
    stage("Prep") {
        deleteDir() // Clean up the workspace
        checkout scm
        withCredentials([file(credentialsId: 'AWS-Jenkins-Integration', variable: 'tfvars')]) {
            sh "cp $tfvars terraform.tfvars"
        }
        sh "terraform init --get=true"
    }
}
