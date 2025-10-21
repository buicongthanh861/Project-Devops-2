def registry = 'https://trialuitjen.jfrog.io'
def imageName = 'trialuitjen.jfrog.io/congthanh-docker-local/ttrend'
def version   = '2.1.2'
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
                sh 'mvn clean package -Dmaven.test.skip=true'
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

     //   stage("Quality Gate"){
       //     steps {
        //        script {
                    // Giới hạn chờ Quality Gate tối đa 1 giờ
        //           timeout(time: 10, unit: 'MINUTES') {
          //              def qg = waitForQualityGate()
           //             if (qg.status != 'OK') {
                            // Dừng pipeline nếu Quality Gate fail
           //                 error "Pipeline aborted due to quality gate failure: ${qg.status}"
             //           }
           //         }
         //       }
         //   }
      //  }


stage("Jar Publish") {
    steps {
        script {
            echo '<--------------- Jar Publish Started --------------->'
            
            def server = Artifactory.newServer(
                url: registry + "/artifactory",
                credentialsId: "artfiact-cred"
            )

            def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}"

            def uploadSpec = """{
                "files": [
                    {
                        "pattern": "target/demo-workshop-*.jar",
                        "target": "maven-libs-release-local/demo-workshop/",
                        "flat": "false",
                        "props": "${properties}",
                        "exclusions": [ "*.sha1", "*.md5" ]
                    }
                ]
            }"""

            def buildInfo = server.upload(uploadSpec)
            buildInfo.env.collect()
            server.publishBuildInfo(buildInfo)

            echo '<--------------- Jar Publish Ended --------------->'
        }
    }
}

    stage(" Docker Build ") {
      steps {
        script {
           echo '<--------------- Docker Build Started --------------->'
           app = docker.build(imageName+":"+version)
           echo '<--------------- Docker Build Ends --------------->'
        }
      }
    }

            stage (" Docker Publish "){
        steps {
            script {
               echo '<--------------- Docker Publish Started --------------->'  
                docker.withRegistry(registry, 'artfiact-cred'){
                    app.push()
                }    
               echo '<--------------- Docker Publish Ended --------------->'  
            }
        }
    }

    stage("Deploy"){
        steps {
            script{
                sh './deploy.sh'
            }
        }
    }


    }
}
