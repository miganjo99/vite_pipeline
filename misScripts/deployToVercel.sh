#!/bin/bash

# Verificar si el token de Vercel está presente en el entorno
if [ -z "$VERCEL_TOKEN" ]; then
  echo "El token de Vercel no está configurado en el entorno. Abortando el despliegue."
  exit 1
fi

# Desplegar la aplicación en Vercel sin necesidad de autenticación previa
echo "Desplegando la aplicación en Vercel..."
vercel --prod --token "$VERCEL_TOKEN" --yes

# Verificar el resultado del despliegue
if [ $? -ne 0 ]; then
  echo "Error al desplegar en Vercel."
  exit 1
else
  echo "Despliegue exitoso en Vercel."
  exit 0
fi
