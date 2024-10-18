pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                // The SCM checkout is handled by Jenkins automatically
                checkout scm
            }
        }
        stage('Flyway Info') {
            steps {
                // Run the Flyway command in the context of the checked-out code
                bat 'flyway info -environment=prod'
            }
        }
    }
}
