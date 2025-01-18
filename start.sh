#!/bin/bash

# Iniciar Strapi
cd /app/AlcolabsStrapi
npm run start &

# Iniciar Express
cd /app/APIREST
node dist/index.js
