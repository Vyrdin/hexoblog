FROM node:18-alpine

RUN npm install -g hexo-cli

WORKDIR /app

COPY . .

RUN npm install && hexo generate

FROM nginx:alpine

COPY --from=0 /app/public /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
