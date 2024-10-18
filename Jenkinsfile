pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Environment') {
            steps {
                script {
                    // Clean, migrate, and undo for Build environment
                    echo 'Pre Build Validation Clean'
                    bat 'flyway clean -environment=Build -cleanDisabled=False'

                    echo 'Build Migration Sctipts Validation'
                    bat 'flyway migrate -environment=Build'

                    echo 'Pre Rollback Scripts Validation Clean'
                    bat 'flyway undo -environment=Build -target="002_20241018021811"'
                }
            }
        }
        stage('UAT Environment') {
            steps {
                script {
                    // Check changes, drift, and code for UAT
                    bat 'flyway info -environment=UAT'
                    bat 'flyway validate -environment=UAT'  // Check for any issues
                    
                    // Create report for UAT with custom report filename
                    bat 'flyway check -changes -drift -dryrun -code -environment=UAT -check.buildEnvironment=Check -reportFilename=report_UAT.html'
                    
                    // Archive the report for UAT
                    archiveArtifacts artifacts: 'report_UAT.html', fingerprint: true
                    
                    input 'Proceed with migration to UAT?'
                    bat 'flyway migrate -environment=UAT'
                }
            }
        }
        stage('Prod Environment') {
            steps {
                script {
                    // Check changes, drift, and code for Prod
                    bat 'flyway info -environment=Prod'
                    bat 'flyway validate -environment=Prod'  // Check for any issues
                    
                    // Create report for Prod with custom report filename
                    bat 'flyway check -changes -drift -dryrun -code -environment=Prod -check.buildEnvironment=Check -reportFilename=report_Prod.html'
                    
                    // Archive the report for Prod
                    archiveArtifacts artifacts: 'report_Prod.html', fingerprint: true
                    
                    input 'Proceed with migration to Prod?'
                    bat 'flyway migrate -environment=Prod'
                }
            }
        }
    }
}
