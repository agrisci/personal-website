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
        container('jnlp') {
          dir("frontend") {
              sh 'echo Building frontend app static bundle'
              sh 'npm install'
              sh 'npm run build'
          }
        }
        container('ubuntu') {
          dir("frontend/dist") {
              sh 'apt-get update && apt-get install poppler-utils -y'
              sh 'pdftocairo resume.pdf -png -scale-to 800'
              sh 'mv resume-1.png resume-small.png'
              sh 'pdftocairo resume.pdf -png -scale-to 1200'
              sh 'mv resume-1.png resume-medium.png'
              sh 'pdftocairo resume.pdf -png'
              sh 'mv resume-1.png resume-large.png'
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