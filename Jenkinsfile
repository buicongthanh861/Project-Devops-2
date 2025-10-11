pipeline {
    agent {
        node {
            label 'maven'
        }
    }
environment {
    PATH = "/opt/apache-maven-3.9.9/bin:$PATH"
}

    stages {
        stage('build') {
            steps {
                sh 'mvn clean deploy -DskipTests'
            }
        }

    stage('SonarQube analysis') {
    environment {
      scannerHome = tool 'sonar-scanner'
    }
    steps{
    withSonarQubeEnv('sonarqube-server') {
      sh "${scannerHome}/bin/sonar-scanner"
        }
    }
    }
}
}

