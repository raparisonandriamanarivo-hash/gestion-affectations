pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build & Test') {
            steps {
                bat 'java --version'
                // Compile et exécute les tests unitaires JUnit en une seule passe
                bat 'mvn clean package'
            }
        }
        
        stage('Deploy') {
            steps {
                // Copie directe du fichier .war généré vers le répertoire webapps de Tomcat sous Windows
                bat 'copy target\\gestion-affectations.war "C:\\apache-tomcat-9.0.120\\webapps\\"'
            }
        }
    }
}