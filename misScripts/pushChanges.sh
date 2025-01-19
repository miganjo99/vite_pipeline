#!/bin/sh

# Personalizar el mensaje del commit
COMMIT_MSG="Pipeline ejecutado por miguel "

# Configurar el acceso a GitHub
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Configurar usuario y correo para git
git config --global user.name "Jenkins Pipeline"
git config --global user.email "jenkins@pipeline.local"

# Asegúrate de estar en la rama correcta
git fetch origin
git checkout branch_pipeline || git checkout -b branch_pipeline

# Agregar archivos y hacer commit
git add README.md
git commit -m "${COMMIT_MSG}" || echo "Nada que commitear."

# Intentar hacer push, si falla, hacer pull con rebase y luego push
git push origin branch_pipeline || {
    echo "Error al hacer push. Intentando hacer pull con rebase..."
    git pull --rebase origin branch_pipeline
    git push origin branch_pipeline
}

exit 0
