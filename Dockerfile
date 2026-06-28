FROM node:18-alpine

RUN npm install -g hexo-cli http-server

WORKDIR /app

COPY . .

# 强制安装依赖
RUN npm install

# 强制初始化（避免空项目）
RUN if [ ! -f "_config.yml" ]; then hexo init . && npm install; fi

# 🔥 强制生成（关键）
RUN hexo clean
RUN hexo generate || (echo "HEX0 GENERATE FAILED" && exit 1)

# 如果没有 public 直接失败（帮你定位）
RUN test -d public || (echo "NO PUBLIC DIR" && ls -la && exit 1)

CMD sh -c "http-server public -p $PORT -a 0.0.0.0"
