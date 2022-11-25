FROM nginx:stable-alpine

COPY ./.docker/default.conf /etc/nginx/conf.d/

EXPOSE 80 443