pipeline {
   environment {
      ENV_USER_HOME = "${env.WORKSPACE}/"
   }

   //
   agent {
      docker {
         image 'runtime-tooling'
         args '--volume ${PWD}:/app --workdir :/app:ro' //read-only access
         reuseNode true
      }
   }

   //The first stage QA
   stages {
      stage('QA') {
         parallel {
            // The substages Release
            stage('Release') {
               steps {
                  // Give commands in Bash and finally builds
                  sh "mkdir -p /tmp/build-release \
                && cd /tmp/build-release \
                && BUILD_TYPE=Release  /var/lib/jenkins/workspace/${env.JOB_NAME} \
                && cmake --build"
               }
            }

            stage('Debug') {
               steps {
                  sh 'mkdir -p /tmp/build-debug'
               }
            }
            stage('Tests') {
               steps {
                  sh 'echo runTests'
               }
            }
         }
         post {
            failure {
               echo 'This build has failed. See logs for details.'
            }
         }
      }
      stage('DEPLOYMENT') {
         parallel {
            stage('Result') {
               steps {
                  sh 'echo Reporting...'
               }
            }
            stage('Deploy Conan Artifacts') {
               steps {
                  sh 'conan remote add project-local '
                  sh 'conan upload'
               }
            }
         }
      }
   }
}
