pipeline {
    agent any
    
    tools {
        // Associe le nom exact défini dans les outils Jenkins
        maven 'Maven-3.x'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build & Test') {
            steps {
                bat 'java --version'
                // Jenkins utilisera automatiquement le Maven configuré ci-dessus
                bat 'mvn clean package'
            }
        }
        stage('Deploy') {
            steps {
                bat 'copy target\\gestion-affectations.war "C:\\apache-tomcat-9.0.120\\webapps\\"'
            }
        }
    }
}
