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
                bat 'java --version'
            }
        }
        
        stage('Test') {
            steps {
                // Exécute automatiquement JUnit via Maven dans Jenkins
                bat 'mvn test'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Simulation du déploiement réussie !'
            }
        }
    }
}