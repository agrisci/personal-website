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
          sh 'echo Building Frontend App Static Bundle'
          dir("frontend") {
              sh 'npm install'
              sh 'npm run build'
          }
        }
      }
    }

    stage('Build Image') {
      steps {
        container(name: 'kaniko', shell: '/busybox/sh') {
          dir("frontend") {
            withEnv(['PATH+EXTRA=/busybox']) {
              sh 'echo Building Frontend App Image'
              script{
                  if (env.GIT_BRANCH == 'origin/main') {
                      env.DOCKER_TAG = "main-$GIT_COMMIT"
                  } else if (env.GIT_BRANCH == 'origin/develop') {
                      env.DOCKER_TAG = "develop-$GIT_COMMIT"
                  } else {
                      env.DOCKER_TAG = "devops-$GIT_COMMIT"
                  }
              }
              sh '/kaniko/executor --dockerfile `pwd`/Dockerfile --context `pwd` --destination 026978711726.dkr.ecr.eu-central-1.amazonaws.com/devops-portfolio:$DOCKER_TAG'
            }
          }
        }
      }
    }
  }
}