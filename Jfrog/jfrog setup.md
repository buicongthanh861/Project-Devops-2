jfrog Artifactory URL: https://trialuitjen.jfrog.io/

Artifact location: /home/ubuntu/home/ubuntu/jenkins/home/ubuntu/jenkins/workspace/_trend_muiltibranch_pieline_main/target

Credentials: artfiact-cred


def registry = 'https://trialuitjen.jfrog.io'
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
