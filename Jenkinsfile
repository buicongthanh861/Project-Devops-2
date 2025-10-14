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
                // Dùng 'install' thay vì 'deploy' để giảm load cho Jenkins agent
                sh 'mvn clean deploy -DskipTests'
                echo "--------build completed-------"
            }
        }

        stage("test") {
            steps {
                echo "------------running unit test--------"
                sh 'mvn test'
            }
            post {
                always {
                    // Thu thập kết quả test để hiển thị trong Jenkins
                    junit '**/target/surefire-reports/*.xml'
                }
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
                    timeout(time: 1, unit: 'HOURS') {
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
