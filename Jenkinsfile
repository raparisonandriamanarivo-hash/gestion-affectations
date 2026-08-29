pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build & Verif Java') {
            steps {
                // Vérifie la version de Java directement sur votre PC Windows via Jenkins
                bat 'java --version'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Tests du projet en cours...'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Simulation du déploiement réussie !'
            }
        }
    }
}
