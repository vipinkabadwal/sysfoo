pipeline {
  agent none
  stages {
    stage('build') {
      agent {
        docker {
          image 'maven:3.6.3-jdk-11-slim'
        }

      }
      steps {
        echo 'compile maven app'
        sh 'mvn compile'
      }
    }

    stage('test') {
      agent {
        docker {
          image 'maven:3.6.3-jdk-11-slim'
        }

      }
      steps {
        echo 'test maven app'
        sh 'mvn clean test'
      }
    }

    stage('package') {
      agent {
        docker {
          image 'maven:3.6.3-jdk-11-slim'
        }

      }
      steps {
        echo 'package maven app'
        sh 'mvn package -DskipTests'
        archiveArtifacts(allowEmptyArchive: true, defaultExcludes: true, caseSensitive: true, artifacts: '**/*.war')
      }
    }

    stage('Docker BnP') {
      agent any
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin') {
            def dockerImage = docker.build("vipindoc/sysfoo:v${env.BUILD_ID}", "./")

            when{
              "${env.BRANCH_NAME} == master"
              {
                dockerImage.push()
              }
            }
          }
        }

      }
    }

  }
}