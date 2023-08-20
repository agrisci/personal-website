pipeline {
  tools {nodejs "node18"}
  
  environment {
        USER_CREDENTIALS = credentials('aws-credentials')
  }

  agent {
    kubernetes {
      defaultContainer 'jnlp'
      yaml '''
            kind: Pod
            spec:
              containers:
              - name: kaniko
                image: gcr.io/kaniko-project/executor:debug
                imagePullPolicy: Always
                tty: true
                command:
                - sleep
                args:
                - 99d
            '''
    }
  }
  stages {
    stage('Build App') {
      steps {
        container('jnlp') {
          dir("frontend") {
              sh 'echo Building frontend app static bundle'
              sh 'npm install'
              sh 'npm run build'
          }
        }
      }
    }

    stage('Build and push docker image to registry') {
      steps {
        container(name: 'kaniko', shell: '/busybox/sh') {
          dir("frontend") {
            withEnv(['PATH+EXTRA=/busybox']) {
              sh 'echo Building frontend image and pushing to registry'
              script{
                  if (env.GIT_BRANCH == 'origin/main') {
                      env.REPO_ENV = "main"
                  } else {
                      env.REPO_ENV = "develop"
                  }
              }
              sh '/kaniko/executor --dockerfile `pwd`/Dockerfile --context `pwd` --destination 026978711726.dkr.ecr.eu-central-1.amazonaws.com/devops-portfolio-$REPO_ENV:latest'
            }
          }
        }
      }
    }
  }
}