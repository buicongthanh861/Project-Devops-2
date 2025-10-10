pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    stages {
        stage('Git-clone') {
            steps {
                git branch: 'main', url: 'https://github.com/buicongthanh861/Project-Devops-2.git'
            }
        }
    }
}