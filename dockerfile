# 前端 Dockerfile
FROM node:22 as builder
WORKDIR /app
COPY . .
RUN npm install -g pnpm
RUN pnpm install && pnpm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf