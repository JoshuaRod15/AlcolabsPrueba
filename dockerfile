FROM node:18-bullseye

# Instalar dependencias del sistema necesarias para sharp
RUN apt-get update && apt-get install -y \
    build-essential \
    libcairo2-dev \
    libjpeg-dev \
    libpango1.0-dev \
    libgif-dev \
    librsvg2-dev

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar archivos del proyecto
COPY . .

# Instalar dependencias para Strapi
WORKDIR /app/AlcolabsStrapi
COPY AlcolabsStrapi/package*.json ./
RUN npm install --platform=linux --arch=arm64 sharp
RUN npm install
COPY AlcolabsStrapi/ .
RUN npm run build

# Instalar dependencias para Express
WORKDIR /app/APIREST
COPY APIREST/package*.json ./
RUN npm install
COPY APIREST/ .
RUN npm run build

# Instalar las dependencias del sistema necesarias para Sharp
RUN apt-get update && apt-get install -y \
  libvips-dev \
  && rm -rf /var/lib/apt/lists/*

# Forzar la instalación de Sharp para el entorno de Linux
RUN npm rebuild sharp --platform=linux --arch=x64


# Copiar el script de inicio
WORKDIR /app
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Exponer puertos
EXPOSE 1337 4000

# Usar el script de inicio
CMD ["/app/start.sh"]
