FROM nginx:alpine

COPY index.html /var/www/html
# COPY index.html /usr/share/nginx/html


EXPOSE 80