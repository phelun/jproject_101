#!/usr/bin/env groovy
/**
        * Standard igroovy comments
        * This should be my template scripted pipeline
        * More comments
*/


import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL

 def seperator80 = '\u2739' * 80
 def seperator80 = '\u2739' * 20

node() {
      stage ('step 1') {
        echo "${seperator80}\n${seperator20} AWScli Version \n${seperator80}"
        sh "aws --version"
        sh "git clone https://github.com/phelun/jproject_101.git"
      }

      stage ('step2 ') {
        echo "${seperator80}\n${seperator20} Terraform Version \n${seperator80}"
        sh "terraform --version"
      }

      stage ('step 3') {
        echo "${seperator80}\n${seperator20} Packer Version \n${seperator80}"
        sh "packer --version"
        sh "ls -R"
      }

      stage ('step 4'){
        sh "ansible --version"
        sh "which ansible-playbook"
      }

      stage ("Terraform Ahead") {
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

      stage ('EC2 spinup') {
        withCredentials([usernamePassword(credentialsId: 'me_aws_id', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]){
        sh 'terraform init ./jproject_101'
        sh 'terraform plan -no-color -out=./jproject_101/create.tfplan ./jproject_101'
        sh 'terraform apply ./jproject_101/create.tfplan'
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
        withCredentials([usernamePassword(credentialsId: 'me_aws_id', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]){
        sh 'terraform destroy -force ./jproject_101'

        }
      }

}
