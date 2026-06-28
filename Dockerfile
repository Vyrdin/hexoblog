FROM node:18-alpine

RUN npm install -g http-server

WORKDIR /app

RUN echo "hello dcdeploy" > index.html

EXPOSE 8080

CMD ["http-server", "-p", "8080", "-a", "0.0.0.0"]
