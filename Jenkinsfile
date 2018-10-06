#!/usr/bin/env groovy
/**
        * Standard igroovy comments
        * This should be my template scripted pipeline
        * More comments
        * 1 -
*/


import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL


properties([
  parameters([
    booleanParam(
      description: "Untick the box if AMI is existing",
      name: "run_ami_step",
      default: true,
    )
  ])
])

def dry_run = false
if (dry_run == true ) {
  run_ami_step = false
}

def seperator60 = '\u2739' * 60
def seperator20 = '\u2739' * 20
def job_name = "${env.JOB_NAME}"
def jon_number = "${env.JOB_NUMBER}"

echo "\u2739 job_name=${job_name}"

node() {
      stage ('AWS CLI TOOL') {
        echo "${seperator60}\n${seperator20} AWScli Version \n${seperator60}"
        sh "aws --version"
        sh "git clone https://github.com/phelun/jproject_101.git"
      }

      stage ('TERRAFORM TOOL ') {
        echo "${seperator60}\n${seperator20} Terraform Version \n${seperator60}"
        sh "terraform --version"
      }

      stage ('PACKER TOOL') {
        echo "${seperator60}\n${seperator20} Packer Version \n${seperator60}"
        sh "packer --version"
      }

      stage ('ANSIBLE TOOL'){
        echo "${seperator60}\n${seperator20} Ansible Version \n${seperator60}"
        sh "ansible --version"
      }

      stage ("Prepare AMI") {
           try {
             timeout(time: 30, unit: 'MINUTES') {
               input message: 'Proceed to next stage?'
             }
           }
           catch (err) {
               echo "Aborted by user!"
               currentBuild.result = 'ABORTED'
               error('Job Aborted')
           }
      }


      stage ("Creating AMI"){
        echo "${seperator60}\n${seperator20} Creating AMI \n${seperator60}"
        echo "run_ami_step : ${run_ami_step}"
        if (run_ami_step == "false") {
        echo "\u2739 run_ami_step set to false, skipping ami creation"
        } else {
          if (dry_run == true ) {echo "Dry Run, skipping" ; return }
          echo "\u2739 starting ami creation"
        withCredentials([usernamePassword(credentialsId: 'me_aws_id', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]){
        sh """
           cd ./jproject_101/br4u-terraform-infra/golden-images/golden-ami-python-br4u
           packer validate packer.json
           packer build packer.json
        """
        }
       }

      stage ("AMI Ready lets spin up instances") {
           try {
             timeout(time: 30, unit: 'MINUTES') {
               input message: 'Proceed to next stage?'
             }
           }
           catch (err) {
               echo "Aborted by user!"
               currentBuild.result = 'ABORTED'
               error('Job Aborted')
           }
      }



      }
      stage ('EC2 spinup') {
        echo "${seperator60}\n${seperator20} Spinning Up instance(s) \n${seperator60}"
        withCredentials([usernamePassword(credentialsId: 'me_aws_id', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]){
        sh """
           cd ./jproject_101/br4u-terraform-infra/brexit4u-dev-django
           terraform init
           terraform plan -out=create.tfplan
           terraform apply create.tfplan
        """
        }
      }

      stage ('Check EC2'){
           try {
             timeout(time: 120, unit: 'MINUTES') {
               input message: 'Proceed to next stage?'
             }
           }
           catch (err) {
               echo "Aborted by user!"
               currentBuild.result = 'ABORTED'
               error('Job Aborted')
           }
      }
      stage ('Destroy instance'){
        echo "${seperator60}\n${seperator20} Destroyinh instances(s) \n${seperator60}"
        withCredentials([usernamePassword(credentialsId: 'me_aws_id', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]){
        sh """
          cd ./jproject_101/br4u-terraform-infra/brexit4u-dev-django
          terraform destroy -force
        """
        }
      }

}
