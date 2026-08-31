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
                // Compilation du projet et génération du fichier .war via Maven
                bat 'mvn clean package -DskipTests'
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
                // Copie directe du fichier .war généré vers le répertoire webapps de Tomcat sous Windows
                bat 'copy target\\gestion-affectations.war "C:\\apache-tomcat-9.0.120\\webapps\\"'
            }
        }
    }
}