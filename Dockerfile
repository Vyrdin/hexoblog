FROM node:18-alpine

RUN npm install -g hexo-cli http-server

WORKDIR /app

# 先复制依赖文件（避免你之前 ENOENT）
COPY package.json ./

RUN npm install

# 再复制全部项目
COPY . .

# 如果是空项目则初始化（防炸）
RUN if [ ! -f "_config.yml" ]; then hexo init . && npm install; fi

# 构建静态站
RUN hexo generate

# 确认生成结果
RUN ls -la public

# DCDeploy 必须用 $PORT
CMD sh -c "http-server public -p $PORT -a 0.0.0.0"
