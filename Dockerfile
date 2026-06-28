FROM node:18-alpine

RUN npm install -g http-server

RUN mkdir /app && echo "OK DCDEPLOY" > /app/index.html

CMD sh -c "http-server /app -p $PORT -a 0.0.0.0"
