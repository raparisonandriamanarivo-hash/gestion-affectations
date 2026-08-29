pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Récupère le code depuis votre dépôt GitHub
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                echo 'Étape de compilation du projet Java/Hibernate...'
                // Nous ajouterons plus tard votre commande de build (ex: Maven, Ant ou javac)
            }
        }
        
        stage('Test') {
            steps {
                echo 'Étape des tests...'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Déploiement de l\'application...'
            }
        }
    }
}
