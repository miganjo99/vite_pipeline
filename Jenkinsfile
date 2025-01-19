pipeline {
    agent any

    tools {
          nodejs "Node" 
     }

    parameters {
        string(name: 'EXECUTOR', defaultValue: '', description: 'miganjo99')
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

        stage('Build') {
            steps {
                script {
                    sh 'npm run build'
                }
            }
        }

        stage('Update_Readme') {
               steps {
                    script {
                         def testResult = readFile('test_result.txt').trim()

                         echo "Actualizando el README.md  (${testResult})..."

                         sh """
                         echo "resultado de updatear el readme:${testResult}..."
                         node ./misScripts/updateReadme.js ${testResult}
                         """

                         writeFile file: 'update_result.txt', text: 'Correcto'
                    }
               }
          }
        

        stage('Push_Changes') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'jenkins-stage-key', keyFileVariable: 'SSH_KEY')]) {
                        echo "Realizando el push al repositorio remoto..."
                        
                        // Crear directorio si no existe
                        sh 'mkdir -p $HOME/.ssh'
                        
                        // Crear el archivo temporal con la clave SSH
                        writeFile file: "$HOME/.ssh/id_rsa", text: SSH_KEY
                        
                        // Ajustar permisos y realizar el push
                        def pushResult = sh(
                            script: """
                            chmod 600 $HOME/.ssh/id_rsa
                            eval \$(ssh-agent -s)
                            ssh-add $HOME/.ssh/id_rsa
                            ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
                            sh ./misScripts/pushChanges.sh '${params.EXECUTOR}' '${params.MOTIVO}'
                            """,
                            returnStatus: true
                        )
                        
                        if (pushResult != 0) {
                            error "El push falló. Revisa el log para más detalles."
                        }
                    }
                }
            }
        }




    }
}
