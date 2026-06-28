FROM node:18-alpine

RUN npm install -g hexo-cli http-server

WORKDIR /app

# 🔥 关键：进入子目录（你 repo 的实际结构）
COPY hexoblog-main/. .

RUN npm install
RUN hexo clean
RUN hexo generate

# 防止 silent fail
RUN test -d public || (echo "NO PUBLIC GENERATED" && ls -la && exit 1)

CMD sh -c "http-server public -p $PORT -a 0.0.0.0"
