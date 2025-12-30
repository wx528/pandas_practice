# 使用官方 Python 轻量级镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 防止 Python 产生 pyc 文件，并让输出直接打印在控制台
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 安装系统依赖（部分 pandas 功能可能需要）
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件并安装
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 暴露 Jupyter Lab 默认端口
EXPOSE 8888

# 启动 Jupyter Lab
# --ip=0.0.0.0 允许外部访问
# --allow-root 允许以 root 用户运行
# --no-browser 不自动在容器内打开浏览器
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]