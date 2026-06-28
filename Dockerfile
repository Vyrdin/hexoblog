FROM node:18-alpine

RUN npm install -g hexo-cli http-server

WORKDIR /app

# ⚠️ 关键：进入子目录
COPY hexoblog-main/. .

RUN npm install

RUN hexo clean
RUN hexo generate

RUN test -d public || (echo "NO PUBLIC" && ls -la && exit 1)

CMD sh -c "http-server public -p $PORT -a 0.0.0.0"
