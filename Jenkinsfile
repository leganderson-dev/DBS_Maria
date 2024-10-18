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
                    bat 'flyway clean -environment=Build -cleanDisabled=False'
                    bat 'flyway migrate -environment=Build'
                    bat 'flyway undo -environment=Build'
                }
            }
        }
        stage('UAT Environment') {
            steps {
                script {
                    // Check changes, drift, and code for UAT
                    bat 'flyway info -environment=UAT'
                    bat 'flyway validate -environment=UAT'  // Check for any issues
                    bat 'flyway check -changes -drift -dryrun -code -environment=UAT -check.buildEnvironment=Check'  // create Reports
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
                    bat 'flyway check -changes -drift -dryrun -code -environment=Prod -check.buildEnvironment=Check'  // create Reports
                    input 'Proceed with migration to Prod?'
                    bat 'flyway migrate -environment=Prod'
                }
            }
        }
    }
}
