#!/usr/bin/env groovy

// See https://github.com/capralifecycle/jenkins-pipeline-library
@Library('cals') _

def tests = [
  'tools/sonar-scanner/install-alpine.test.Dockerfile',
]

def jobProperties = []

if (env.BRANCH_NAME == 'master') {
  jobProperties << pipelineTriggers([
    // Build a new version every night so we keep up to date with upstream changes
    cron('H H(2-6) * * *'),
  ])
}

buildConfig([
  jobProperties: jobProperties,
  slack: [
    channel: '#cals-dev-info',
    teamDomain: 'cals-capra',
  ],
]) {
  // Plan parallel steps
  def branches = [:]
  tests.each { dockerfile ->
    branches[dockerfile] = {
      dockerNode {
        checkout scm
        sh "docker build --no-cache -f $dockerfile ."
      }
    }
  }

  parallel branches
}
