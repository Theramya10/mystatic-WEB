pipeline {
    agent any
    parameters {
        booleanParam(name: 'DESTROY_ENVIRONMENT', defaultValue: false, description: 'Destroy infra?')
    }
    stages {
        stage('Terraform Init') {
            steps { sh 'terraform init' }
        }
        stage('Terraform Validate') {
            steps { sh 'terraform validate' }
        }
        stage('Terraform Plan') {
            steps { sh 'terraform plan' }
        }
        stage('Terraform Apply') {
            steps { sh 'terraform apply -auto-approve' }
        }
        stage('Terraform Destroy') {
            when { expression { return params.DESTROY_ENVIRONMENT } }
            steps { sh 'terraform destroy -auto-approve' }
        }
    }
}
