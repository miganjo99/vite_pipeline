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

         stage('Linter') {
               steps {
                    script {
                         def lintResult = sh script: 'npx eslint .', returnStatus: true

                         if (lintResult != 0) {
                              writeFile file: 'result_lint.txt', text: 'Error'
                              error "ERROR en el linter"
                         } else {
                              writeFile file: 'result_lint.txt', text: 'Correcto'
                         }
                         echo "Linter correcto"
                    }
               }
          }

          stage('Test') {
               steps {
                    script {
                         def testResult = sh(script: 'npm test', returnStatus: true)

                         if (testResult != 0) {
                              writeFile file: 'test_result.txt', text: 'Error'
                              error "ERROR en los tests"
                         } else {
                              writeFile file: 'test_result.txt', text: 'Correcto'
                         }
                         echo "Todos los tests funcionaron correctamente."
                    }
               }
          }
    }
}
