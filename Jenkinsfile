pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    stages {
        stage('git checkout') {
            steps {
                git changelog: false, poll: false, url: 'https://github.com/karthikvee/terraform-elb-asg.git'
            }
        }
        stage('terraform init') {
            steps {
                dir('environments/dev') {
                    sh 'terraform init'
                }
            }
        }
        stage('terraform apply/destroy') {
            steps {
                dir('environments/dev') {
                    sh 'terraform apply --auto-approve'
                }
            }
        }
    }
}

