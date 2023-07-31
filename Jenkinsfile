pipeline {
  tools {nodejs "node18"}
  agent {
    kubernetes {
      defaultContainer 'jnlp'
      yaml '''
        kind: Pod
        spec:
          containers:
          - name: kaniko
            image: gcr.io/kaniko-project/executor:v1.6.0-debug
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
    stage('Build') {
      steps {
        git 'https://github.com/jenkinsci/docker-inbound-agent.git'
        container('jnlp') {
            sh 'echo Building'
        }
      }
    }

    stage('Test') {
      steps {
        container('jnlp') {
            sh 'echo Testing'
        }
      }
    }

    stage('Deploy') {
      steps {
        container(name: 'kaniko', shell: '/busybox/sh') {
            withEnv(['PATH+EXTRA=/busybox']) {
                sh 'ls -l'
                sh '/kaniko/executor --help'
            }
        }
      }
    }
  }
}