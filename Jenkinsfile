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
                      env.DOCKER_TAG = "main-$GIT_COMMIT"
                  } else {
                      env.DOCKER_TAG = "develop-$GIT_COMMIT"
                  }
              }
              sh '/kaniko/executor --dockerfile `pwd`/Dockerfile --context `pwd` --destination 026978711726.dkr.ecr.eu-central-1.amazonaws.com/devops-portfolio:$DOCKER_TAG'
            }
          }
        }
      }
    }

    stage('Bump helm chart version') {
      steps {
        sshagent(credentials: ['3c30a640-8c51-4770-b7cb-e6b1dfd45cb6']) {
          dir("frontend/helm/values"){
            sh 'echo Bumping helm chart version'
            script{
              if (env.GIT_BRANCH == 'origin/main') {
                  env.DOCKER_TAG = "main-$GIT_COMMIT"
                  env.BRANCH = "main"
              } else {
                  env.DOCKER_TAG = "develop-$GIT_COMMIT"
                  env.BRANCH = "develop"
              }
            }
            sh 'git checkout $BRANCH'
            sh 'sed -E "s|image: .*|image: ${DOCKER_TAG}|" "./${BRANCH}.yaml" > temp.yaml'
            sh 'mv temp.yaml $BRANCH.yaml'
            sh 'git config --global user.name "Jenkins"'
            sh "git config --global user.email jenkins@ci.com"
            sh 'git add .'
            sh 'git commit -m "[Jenkins] Updated helm chart"'
            sh 'git push origin $BRANCH'
          }
        }
      }
    }
  }
}