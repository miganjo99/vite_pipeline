#!/bin/bash

# Verificar si el token de Vercel está presente en el entorno
if [ -z "$VERCEL_TOKEN" ]; then
  echo "El token de Vercel no está configurado en el entorno. Abortando el despliegue."
  exit 1
fi

# Autenticarse en Vercel con el token
echo "Autenticándose en Vercel..."
vercel login --token "$VERCEL_TOKEN"

# Desplegar la aplicación en Vercel
echo "Desplegando la aplicación en Vercel..."
vercel --prod --token "$VERCEL_TOKEN"

# Verificar el resultado del despliegue
if [ $? -ne 0 ]; then
  echo "Error al desplegar en Vercel."
  exit 1
else
  echo "Despliegue exitoso en Vercel."
  exit 0
fi
