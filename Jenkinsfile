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

                        def localSshKeyPath = '/c/Users/Miguel/.ssh/id_rsa'

                        def sshDir = '/var/jenkins_home/.ssh' 
                        def sshKeyPath = "${sshDir}/id_rsa"

                        sh """
                            mkdir -p ${sshDir}
                            cp ${localSshKeyPath} ${sshKeyPath}
                            chmod 600 ${sshKeyPath}
                            eval \$(ssh-agent -s)
                            ssh-add ${sshKeyPath}
                            ssh-keyscan -t rsa github.com >> ${sshDir}/known_hosts

                            # Configura el nombre y correo para git
                            git config --global user.name "Jenkins Pipeline"
                            git config --global user.email "jenkins@pipeline.local"

                            sh ./misScripts/pushChanges.sh '${params.EXECUTOR}' '${params.MOTIVO}'
                        """
                    }
                }
            }
        }






    }
}
