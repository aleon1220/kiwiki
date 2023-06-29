// Capturing sh command output in the env variable

pipeline {
    agent any

    environment {
        LS = "${sh(script:'ls -lah', returnStdout: true).trim()}"
    }

    stages {
        stage("Env Variables") {
            steps {
                echo "LS = ${env.LS}"
            }
        }
    }
}

// source https://e.printstacktrace.blog/jenkins-pipeline-environment-variables-the-definitive-guide/