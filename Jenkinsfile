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
      stage ('deploy') {
          steps {
              withCredentials([[
                  $class: 'AmazonWebServicesCredentialsBinding',
                  credentialsId: 'jenkins',
                  accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                  secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
              ]]) {
                  sh 'AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} AWS_DEFAULT_REGION=us-east-1 ${AWS_BIN} ecs update-service --cluster default --service test-deploy-svc --task-definition test-deploy:2 --desired-count 0'
                  sh 'sleep 1m' // SOOOO HACKY!!!
                  sh 'AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} AWS_DEFAULT_REGION=us-east-1 ${AWS_BIN} ecs update-service --cluster default --service test-deploy-svc --task-definition test-deploy:2 --desired-count 1'
        }

      }

      stage ('step 1') {
        sh "aws --version"
      }

      stage ('step2 ') {
        sh "terraform --version"
      }

      stage ('step 3') {
        sh "packer --version"
      }
}
