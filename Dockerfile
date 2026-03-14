FROM node:24-alpine

WORKDIR /app

# 安装视频处理依赖（构建阶段内置 yt-dlp）
RUN apk add --no-cache ffmpeg yt-dlp \
    && yt-dlp --version

# 复制 package 文件
COPY package*.json ./

# 安装依赖
RUN npm ci --only=production

# 复制源代码
COPY . .

# 暴露端口
EXPOSE 7860

# 设置环境变量
ENV NODE_ENV=production
ENV PORT=7860

# 启动应用
CMD ["node", "index.js"]


