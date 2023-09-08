# 阶段一：构建前端应用
FROM node:14 as builder

# 设置工作目录
WORKDIR /app

# 复制前端代码到工作目录
COPY . .

# 安装前端依赖
RUN npm install

# 构建前端应用
RUN npm run build:prod

# 阶段二：生产环境镜像
FROM nginx:alpine

# 复制阶段一中构建好的前端应用到Nginx的默认静态文件目录
COPY --from=builder /app/dist/ /usr/share/nginx/html

# 暴露Nginx的默认HTTP端口
EXPOSE 9528

# 启动Nginx
CMD ["nginx", "-g", "daemon off;"]
