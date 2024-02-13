# 基础镜像
FROM debian:bookworm

# 作者信息
LABEL MAINTAINER="xiaoqidun@gmail.com"

# 软件仓库
RUN sed -i "s|deb.debian.org|mirrors.ustc.edu.cn|g" /etc/apt/sources.list.d/debian.sources \
    && sed -i "s|main|main contrib non-free non-free-firmware|g" /etc/apt/sources.list.d/debian.sources

# 安装软件
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y curl steamcmd \
    && rm -rf /var/lib/apt/lists/*

# 切换用户
RUN useradd -m steam
USER steam

# 安装服务
RUN /usr/games/steamcmd +login anonymous +app_update 2394010 validate +quit \
    && mkdir -p /home/steam/.steam/sdk64 \
    && cp /home/steam/.local/share/Steam/steamcmd/linux64/steamclient.so /home/steam/.steam/sdk64/steamclient.so

# 工作目录
WORKDIR /home/steam/.local/share/Steam/steamapps/common/PalServer

# 启动命令
ENTRYPOINT ["./PalServer.sh"]