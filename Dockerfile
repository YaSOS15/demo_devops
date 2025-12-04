# Image nginx légère
FROM nginx:stable-alpine

# Efface la page par défaut de nginx
RUN rm -rf /usr/share/nginx/html/*

# Copie TON site web dans le dossier web de nginx
COPY ./ /usr/share/nginx/html

# Ouvre le port 80 (port web)
EXPOSE 80

# Démarre nginx
CMD ["nginx", "-g", "daemon off;"]
