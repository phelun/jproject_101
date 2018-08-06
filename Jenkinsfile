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


//properties([
// parameters([
//    string(defaultValue: ' ', description: 'Any additonal options, e.g. -vvv', name: 'ansible_options'),
//    choice(choices: "inseason\nnap", description: "Brand to deploy to", name: "brand"),
//    string(description: "Environment to deploy to. e.g. int00", name: "environment"),
//    choice(choices: "blue\ngreen", name: "stack"),
//    choice(choices: "wcs\nwxs\ncms", name: "application"),
//    choice(description: "Required only for WCS deploy", choices: 'full\ndelta', name: 'deploy_type'),
//    string(description: "Artifactory build name from which the artifacts are fetched", name: "ArtifactoryBuild"),
//    string(description: "Artifactory build number from which the artifacts are fetched", name: "ArtifactoryBuildNumber")
//  ])
//])


node() {

      stage ('step 1') {
        sh "aws --version"
      }

      stage ('step2 ') {
        sh "terraform --version"
      }

      stage ('step 3') {
        sh "packer --version"
      }

      stage ('packing') {
        withCredentials([usernamePassword(credentialsId: 'me_aws_id', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]){
        sh 'packer build -var aws_access_key=${AWS_ACCESS_KEY_ID} -var aws_secret_key=${AWS_SECRET_ACCESS_KEY} jproject_101/hybrid_ami.json'
        }
      }

}
