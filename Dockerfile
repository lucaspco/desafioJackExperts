FROM nginx:alpine

# Copia o HTML avançado customizável para a pasta do Nginx
COPY index.html /usr/share/nginx/html/index.html

# Define um usuário não-root
RUN adduser -D -g '' appuser && chown -R appuser /usr/share/nginx/html
USER appuser

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]