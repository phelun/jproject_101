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



node() {
      env.PATH += ":/jproject_101"
      stage ('step 1') {
        sh "aws --version"
        sh "git clone https://github.com/phelun/jproject_101.git"
      }

      stage ('step2 ') {
        sh "terraform --version"
      }

      stage ('step 3') {
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
        sh 'terraform init '
        sh 'terraform plan -no-color -out=create.tfplan '
        sh 'terraform apply -no-color create.tfplan'
        }
      }

      stage ('Check EC2'){
          try {
            timeout(time:120, unit: 'MINUTE'){
              input message: 'Destroy environment'
            }
          }
          catch (err){
              echo "Aborted by user!"
              currentBuild.result = 'ABORTED'
              error('Job Aborted')
          }
      }
      stage ('Destroy instance'){
        withCredentials([usernamePassword(credentialsId: 'me_aws_id', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]){
        sh 'terraform destroy ./jproject_101 -force -var aws_access_key=${AWS_ACCESS_KEY_ID} -var aws_secret_key=${AWS_SECRET_ACCESS_KEY}'

        }
      }

}
