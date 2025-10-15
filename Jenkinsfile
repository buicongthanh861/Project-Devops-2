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
                echo "--------build started------"
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                echo "--------build completed-------"
            }
        }

        stage("test"){
            steps{
                echo "----------- unit test started ----------"
                sh 'mvn surefire-report:report'
                 echo "----------- unit test Complted ----------"
            }
        }

        stage('SonarQube analysis') {
            environment {
                // Khai báo tool SonarScanner đã cấu hình trong Jenkins
                scannerHome = tool 'sonar-scanner'
            }
            steps{
                withSonarQubeEnv('sonarqube-server') {
                    // Chạy scan code SonarQube
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        stage("Quality Gate"){
            steps {
                script {
                    // Giới hạn chờ Quality Gate tối đa 1 giờ
                    timeout(time: 10, unit: 'MINUTES') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            // Dừng pipeline nếu Quality Gate fail
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }
    }
}
