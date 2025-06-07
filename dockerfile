FROM node:latest

# 设置淘宝镜像源并安装pnpm
RUN npm config set registry https://registry.npmmirror.com && \
    npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
EXPOSE 5173
CMD ["pnpm", "run", "dev"]