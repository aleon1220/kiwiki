
stage('Create software Artifacts') {
    parallel {
        stage('Parallel Create Artifacts') {
            steps {
                sh  label: 'Parallel execution',
                                    script: '''#!/bin/bash
                                        set -x
                                        echo "Parallel Stage 1 DBG=Date is $(date)"
                                        ./script_AOSP.sh -z
                                    '''
            }
            post {
                always {
                    sh  label: 'Post stage A execution',
                                        script: '''#!/bin/bash
                                                set -x
                                                echo "Post execution stage 1 DBG=Date is $(date)"
                                        '''
                }
            }
                        } // stage
        stage('Create Updater .UPD') {
            steps {
                sh  label: 'Parallel execution Stage 2',
                                    script: '''#!/bin/bash
                                        set -x
                                        echo "Parallel Stage 2 DBG=Date is $(date)"
                                        echo "Creating Updater"
                                    '''
            }
        }
    }
} // stage
