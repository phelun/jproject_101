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


node{
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

