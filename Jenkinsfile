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
              - name: ubuntu
                image: ubuntu:jammy-20230804
                imagePullPolicy: IfNotPresent
                tty: true
                command:
                - sleep
                args:
                - 99d
              - name: kaniko
                image: gcr.io/kaniko-project/executor:debug
                imagePullPolicy: IfNotPresent
                tty: true
                command:
                - sleep
                args:
                - 99d
              - name: aws-cli
                image: amazon/aws-cli
                imagePullPolicy: IfNotPresent
                tty: true
                command:
                - sleep
                args:
                - 99d
            '''
    }
  }
  stages {
    stage('Set environment variables') {
      steps {
        script{
          if (env.GIT_BRANCH == 'origin/develop') {
            env.BRANCH = "develop"
          }else{
            env.BRANCH = "main"
          }
        }
      }
    }
    
    stage('Build apps') {
      steps {
        container('ubuntu') {
          dir("frontend") {
            sh 'echo Building frontend app static bundle'
            sh 'npm install'
            sh 'npm run build'
          }
        }
      }
    }

    stage('Build and push docker images to registry') {
      steps {
        container(name: 'kaniko', shell: '/busybox/sh') {
          dir("frontend") {
            withEnv(['PATH+EXTRA=/busybox']) {
              sh 'echo Building frontend image and pushing to registry'
              sh "/kaniko/executor --dockerfile `pwd`/Dockerfile --context `pwd` --destination 026978711726.dkr.ecr.eu-central-1.amazonaws.com/personal-website-${env.BRANCH}:latest"
            }
          }
        }
      }
    }

    stage('Redeploy images to the ECS cluster') {
      steps {
        container(name: 'aws-cli') {
          sh 'echo Redeploying frontend image'
          sh "aws ecs update-service --cluster ecs-cluster --service personal-website-${env.BRANCH}-service --force-new-deployment --region eu-central-1"
        }
      }
    }
  }
}