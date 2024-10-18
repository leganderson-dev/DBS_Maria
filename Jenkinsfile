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
                    // Clean BUILD
                    bat label: 'Pre Build Validation Clean', script: 'flyway clean -environment=Build -cleanDisabled=False'
                    
                    // Migrate BUILD
                    bat label: 'Validate Migration Scripts', script: 'flyway info migrate info -environment=Build'
                    
                    // Undo BUILD
                    bat label: 'Validate Undo Scripts', script: 'flyway info undo info -environment=Build -target="002.20241018021811"'
                }
            }
        }
        stage('UAT Environment') {
            steps {
                script {
                    // INFO and VALIDATE
                    bat label: 'Status of UAT migrations', script: 'flyway info -environment=UAT'
                    bat label: 'Validate script Integrity', script: 'flyway validate -environment=UAT'  // Check for any issues
                    
                    // Create report for UAT
                    bat label: 'Create Change, Drift, Code Analysis and DryRun Reports', script: 'flyway check -changes -drift -dryrun -code -environment=UAT -check.buildEnvironment=Check -reportFilename=report_UAT.html'
                    
                    // Archive the report for UAT
                    archiveArtifacts artifacts: 'report_UAT.html', fingerprint: true
                    
                    input 'Proceed with migration to UAT?'
                    bat label: 'Migrate Pending Scripts to UAT', script: 'flyway info migrate info -environment=UAT'
                }
            }
        }
        stage('Prod Environment') {
            steps {
                script {
                    // Check changes, drift, and code for Prod
                    bat label: 'Status of Prod migrations', script: 'flyway info -environment=Prod'
                    bat label: 'Validate script Integrity', script: 'flyway validate -environment=Prod'  // Check for any issues
                    
                    // Create report for Prod with custom report filename
                    bat label: 'Create Change, Drift, Code Analysis and DryRun Reports', script: 'flyway check -changes -drift -dryrun -code -environment=Prod -check.buildEnvironment=Check -reportFilename=report_Prod.html'
                    
                    // Archive the report for Prod
                    archiveArtifacts artifacts: 'report_Prod.html', fingerprint: true
                    
                    input 'Proceed with migration to Prod?'
                    bat label: 'Migrate Pending Scripts to Prod', script: 'flyway info migrate info -environment=Prod'
                }
            }
        }
    }
}
