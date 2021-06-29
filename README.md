#steps-1
configure aws credentials in aws cli with command 
```
aws configure
```
#step-2
switch to environment and deploy terraform after updating configuration in main.tf file 
```
cd environments/dev
terraform init
terraform plan
terraform apply
```
Jenkins Ec2 instance from where the terraform code is applied needs to be assigned with the Admin IAM role attached to be able to perform all terraform actions

Terraform plugin is to be installed on Jenkins and configured in global tools configuration with directory location of terraform binary
Terraform binary has to be installed on Jenkins Machine
