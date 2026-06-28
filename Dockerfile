FROM node:18-alpine

RUN npm install -g hexo-cli http-server

WORKDIR /app

COPY . .

RUN npm install
RUN hexo clean
RUN hexo generate

# fail fast（防止你之前 silent error）
RUN test -d public || (echo "BUILD FAILED: no public" && ls -la && exit 1)

CMD sh -c "http-server public -p $PORT -a 0.0.0.0"
