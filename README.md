# React + Vite

# Vite Pipeline - Jenkins Integration and Vercel Deployment

Este proyecto tiene como objetivo automatizar el proceso de integración continua y despliegue continuo (CI/CD) para un proyecto utilizando Vite. El flujo de trabajo se gestiona mediante Jenkins y se realiza el despliegue en Vercel. A continuación, se describen los pasos realizados para configurar este flujo de trabajo.

## Pasos realizados

### 1. **Instalación de Vercel CLI**
Para interactuar con Vercel desde la terminal, instalamos la **Vercel CLI** de forma global utilizando el siguiente comando:

```bash
npm install -g vercel
```

### 2. **Configuración del Token de Despliegue de Vercel**
Para permitir la autenticación con Vercel desde Jenkins, creamos un token de despliegue en la plataforma de Vercel. Para hacerlo, seguimos estos pasos:

- Ingresamos a nuestra cuenta en Vercel.
- Accedemos a la sección de Configuración y generamos un nuevo token de despliegue.
- Guardamos este token como una credencial secreta en Jenkins con el ID `vercel-deploy-token`.

### 3. **Configuración de Jenkins para Integración con Vercel**
En Jenkins, creamos un pipeline para automatizar el flujo de trabajo de despliegue. El pipeline está compuesto por las siguientes etapas:

#### a) Checkout del Repositorio
Se configura el pipeline para realizar el checkout del código desde un repositorio Git, utilizando SSH para autenticar el acceso de forma segura.

#### b) Configuración de Credenciales de Git
En Jenkins, configuramos las credenciales necesarias para realizar operaciones con Git, como el commit y el push de los cambios. Esto se realiza utilizando una clave SSH generada previamente y almacenada en Jenkins.

#### c) Configuración del Nombre de Usuario y Correo Electrónico de Git
Configuramos el nombre y correo del autor en Git para que los commits se registren correctamente. Los comandos utilizados son:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tuemail@example.com"
```

#### d) Realización del Commit y Push a GitHub
Una vez realizados los cambios necesarios en los archivos (como el `README.md`), el pipeline realiza un commit con el mensaje personalizado y realiza un push de los cambios a la rama `branch_pipeline` del repositorio.

#### e) Despliegue a Vercel
Después de realizar el commit y el push, se configura una etapa para hacer el despliegue a Vercel. Esto se hace utilizando el siguiente script:

```bash
vercel --token ${{ secrets.vercel-deploy-token }} --prod
```

### 4. **Ejecución del Pipeline en Jenkins**
El pipeline en Jenkins está configurado para ejecutarse de manera automática cada vez que se realicen cambios en el repositorio. Si todo el flujo se ejecuta correctamente, el código es desplegado a Vercel, y el proyecto estará disponible en línea.

### 5. **Configuración de la Conexión SSH en Jenkins**
Para garantizar una conexión segura con GitHub, configuramos las claves SSH en Jenkins y las almacenamos en el directorio adecuado.

### 6. **Despliegue en Vercel**
La etapa final consiste en hacer el despliegue del proyecto a Vercel. Aseguramos la autenticación mediante el uso de un token de despliegue configurado en Jenkins.

Este pipeline automatiza el proceso de integración y despliegue, desde la actualización del repositorio Git hasta el despliegue en Vercel, mejorando la eficiencia y reduciendo la intervención manual. Cada vez que se realicen cambios en el repositorio, Jenkins se encargará de realizar los pasos de CI/CD automáticamente, asegurando un flujo de trabajo continuo.

## Requisitos
- **Jenkins**: Configurado y corriendo en tu servidor o localmente.
- **Vercel**: Cuenta configurada con proyectos y acceso al token de despliegue.
- **GitHub**: Repositorio configurado con acceso SSH para Jenkins.
- **Node.js y npm**: Instalados para gestionar dependencias y el despliegue en Vercel.


## Resultados de los tests

![Success](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)