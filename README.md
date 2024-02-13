# palgs

Palworld Game Server（幻兽帕鲁游戏服务器）

# docker

## 拉取镜像

```shell
docker pull ccr.ccs.tencentyun.com/xiaoqidun/palgs:latest
```

## 运行镜像

```shell
docker run -d -p 8211:8211/udp ccr.ccs.tencentyun.com/xiaoqidun/palgs:latest
```

# docker compose

## 创建配置

```shell
# 项目目录
export project=$(pwd)/palgs
# 数据目录
mkdir -p $project/Saved
chown -R 1000:1000 $project/Saved
# 创建配置
cat > $project/docker-compose.yml << CODE
services: 
    palgs:
        image: 'ccr.ccs.tencentyun.com/xiaoqidun/palgs:latest'
        restart: 'always'
        container_name: 'palgs'
        ports:
            - '8211:8211/udp'
        volumes:
            - '$project/Saved:/home/steam/.local/share/Steam/steamapps/common/PalServer/Pal/Saved'
        environment: 
            - 'TZ=Asia/Shanghai'
CODE
```