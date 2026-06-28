FROM node:18-alpine

# 安装基础依赖
RUN apk add --no-cache git bash

# 安装 Hexo CLI
RUN npm install -g hexo-cli

# 工作目录
WORKDIR /app

# 只复制依赖文件（优化构建缓存）
COPY package*.json ./

# 安装依赖（如果是已有项目）
RUN npm install || true

# 再复制项目文件
COPY . .

# 初始化（如果是空项目会生效）
RUN if [ ! -f "_config.yml" ]; then \
      hexo init . && npm install; \
    fi

# 构建静态文件
RUN hexo generate

# 暴露端口
EXPOSE 4000

# 启动服务（生产推荐 serve 模式）
CMD ["hexo", "server", "-p", "4000", "-i", "0.0.0.0"]
