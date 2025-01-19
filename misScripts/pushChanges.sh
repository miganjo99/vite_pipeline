#!/bin/sh

# Variables de entrada
EXECUTOR="$1"
MOTIVO="$2"

# Personalizar el mensaje del commit
COMMIT_MSG="Pipeline ejecutada por ${EXECUTOR}. Motivo: ${MOTIVO}"

# Configurar el acceso a GitHub
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

git config --global user.name "${EXECUTOR}"
git config --global user.email "jenkins@pipeline.local"

git add README.md

git commit -m "${COMMIT_MSG}" || echo "Nada que commitear."

git push origin branch_pipeline || {
    echo "Error al hacer push. Intentando hacer pull con rebase..."
    git pull --rebase origin branch_pipeline
    git push origin branch_pipeline
}

exit 0
