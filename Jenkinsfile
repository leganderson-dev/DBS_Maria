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
                    // Clean step with a custom label
                    bat label: 'Pre Build Validation Clean', script: 'flyway clean -environment=Build -cleanDisabled=False'
                    
                    // Migrate step with a custom label
                    bat label: 'Validate Pending Migration Scripts', script: 'flyway migrate -environment=Build'
                    
                    // Undo step with a custom label
                    bat label: 'VAlidate Undo Scripts', script: 'flyway undo -environment=Build'
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
