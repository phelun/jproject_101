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

      stage ('packing') {
        withCredentials([usernamePassword(credentialsId: 'me_aws_id', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]){
        sh 'packer build -var aws_access_key=${AWS_ACCESS_KEY_ID} -var aws_secret_key=${AWS_SECRET_ACCESS_KEY} ./jproject_101/hybrid_ami.json 2>&1 | sudo tee output.txt'
        }
      }

      stage ('Grab AMI ID'){
        sh "tail -2 output.txt | head -2 | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }' > sudo ./jproject_101/ami.txt"
        sh "cat ./jproject_101/ami.txt"
      }

      stage("Terraform Ahead") {
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

}
