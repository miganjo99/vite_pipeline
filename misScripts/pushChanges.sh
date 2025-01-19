#!/bin/sh

# Personalizar el mensaje del commit
COMMIT_MSG="Pipeline ejecutado por miguel "

# Configurar el acceso a GitHub
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Configurar usuario y correo para git
git config --global user.name "Jenkins Pipeline"
git config --global user.email "jenkins@pipeline.local"

# Verificar si ya hay cambios sin confirmar
if ! git diff --quiet; then
  echo "Hay cambios sin confirmar, realizaremos un commit..."
  git add .
  git commit -m "${COMMIT_MSG}"
else
  echo "No hay cambios que confirmar."
fi

# Asegurarse de que estamos en la rama branch_pipeline
git fetch origin

# Si ya estamos en la rama correcta, no hacemos nada
current_branch=$(git symbolic-ref --short HEAD)

if [ "$current_branch" != "branch_pipeline" ]; then
  echo "Cambiando a la rama branch_pipeline..."
  git checkout branch_pipeline
fi

# Agregar archivos y hacer commit en la rama correcta
git add README.md
git commit -m "${COMMIT_MSG}" || echo "Nada que commitear."

# Iniciar ssh-agent para asegurar que la clave SSH esté disponible
eval $(ssh-agent -s)
ssh-add /var/jenkins_home/.ssh/id_rsa

# Intentar hacer push
echo "Haciendo push a la rama branch_pipeline..."
git push origin branch_pipeline || {
    echo "Error al hacer push. Intentando hacer pull con rebase..."
    git pull --rebase origin branch_pipeline
    git push origin branch_pipeline
}

exit 0
