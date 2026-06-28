FROM node:18-alpine

RUN npm install -g hexo-cli http-server

WORKDIR /app

COPY . .

RUN npm install
RUN hexo generate

# ⚠️ 关键：确认 public 一定存在
RUN ls -la public

CMD sh -c "http-server public -p $PORT -a 0.0.0.0"
