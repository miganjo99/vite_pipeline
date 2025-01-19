pipeline {
    agent any

    tools {
          nodejs "Node" 
     }

    parameters {
        string(name: 'EXECUTOR', defaultValue: '', description: 'Miguel Gandia Jordá')
        string(name: 'MOTIVO', defaultValue: '', description: 'pipeline de Jenkins')
        string(name: 'CHAT_ID', defaultValue: '', description: 'Chat ID de Telegram')
    }


    stages {
        stage('Hello World') {
            steps {
                script {
                    echo "Hello, ${params.EXECUTOR}!"
                    echo "Motiu: ${params.MOTIVO}"
                    echo "Chat ID: ${params.CHAT_ID}"
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    echo "Install depemdencies..."
                    sh 'npm install'
                    echo "Install CLI de Vercel..."
                    sh 'npm install -g vercel'
                    echo "Verificant la CLI de Vercel..."
                    sh 'vercel --version'
                }
            }
        }
    }
}
