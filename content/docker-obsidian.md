---
draft: true
title: obsidian-web 分析
aliases: [obsidian web 部署, obsidian-web 分析, 分析, 方案分析]
tags: []
created: 2025-03-09T11:46:46
updated: 2025-03-09T15:20:33
---
还在为跨平台同步笔记头疼吗？试试 Docker-Obsidian！基于 kasmVNC 远程桌面技术，支持 WebDAV 协议，部署简单，中文友好，让你在浏览器中也能享受与本地 Obsidian 几乎一致的流畅体验。无论是 Windows、Mac 还是 Linux，只需一个 Docker 命令，你的知识库就能随时随地 " 在线 "。

# obsidian-web 分析
* docker-obsidian 是 [linuxserver.io](https://linuxserver.io/) 在 2024 年 4 月才开源的第一个版本，难怪去年我找 obsidian 的 web 方案没发现。
* docker-obsidia 基于 `kasmVNC` 远程桌面（号称下一代开源 VNC，Web-Native, Secure and High-Performance）,实测显示效果不错，交互快捷键都和本地一致；
* 通过浏览器访问，支持基础密码认证，支持本地输入法，和本地 obsidian 客户端的效果接近一致。
* obsidian 的数据如果是存储在 NAS/VPS，客户端用 webdav 协议连，服务端把 vault 目录挂载到 docker-obsidian 容器内即可；

## obsidian web 部署
### 项目信息
* 项目地址： https://github.com/linuxserver/docker-obsidian
* 部署文档： https://docs.linuxserver.io/images/docker-obsidian

![[conve-docker-obsidian.png]]

### docker-compose.yml

```yml
services:
  obsidian:
    image: lscr.io/linuxserver/obsidian:latest
    container_name: obsidian
    security_opt:
      - seccomp:unconfined
    network_mode: "host"
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Shanghai
      - DOCKER_MODS=linuxserver/mods:universal-package-install
      - INSTALL_PACKAGES=fonts-noto-cjk
      - LC_ALL=zh_CN.UTF-8
      - CUSTOM_USER=obsidian
      - PASSWORD=obsidian
      - TITLE="obsidian-web"
    volumes:
      - /mnt/mind/data/kbase/kbase:/home/root/kbase
      - /mnt/mind/config/docker-obsidian:/config
    devices:
      - /dev/dri:/dev/dri
    ports:
      - 13000:3000
      - 13001:3001
    shm_size: "2gb"
    restart: unless-stopped
```

### 配置说明
* **security_opt**: 设置安全选项 `seccomp:unconfined`，允许容器不受 seccomp 配置文件的限制。
* **network_mode**: 使用 `host` 网络模式，容器将直接使用宿主机的网络栈。
* **environment**: 设置环境变量：
  * `PUID` 和 `PGID`: 设置容器内运行进程的用户和组 ID。
  * `TZ`: 设置时区为 `Asia/Shanghai`。
  * `DOCKER_MODS`: 指定 Docker 模块 `linuxserver/mods:universal-package-install`，用于安装中文显示。
  * `INSTALL_PACKAGES`: 安装 `fonts-noto-cjk` 字体包，支持中日韩文字。
  * `LC_ALL`: 设置语言环境为 `zh_CN.UTF-8`，支持中文。
  * `CUSTOM_USER` 和 `PASSWORD`: 设置自定义用户名和密码。
  * `TITLE`: 设置网页标题为 `obsidian-web`。
* **volumes**: 挂载卷：
  * `/mnt/gogs/kbase` 挂载到容器内的 `/mnt/gogs/kbase`，用于持久化存储数据。
  * `/home/geosmart/.config/docker-obsidian` 挂载到容器内的 `/config`，用于存储配置。
* **devices**: 挂载设备 `/dev/dri`，允许容器访问宿主机的显卡设备，用于 GPU 渲染加速。
* **ports**: 映射端口：
  * `13000:3000` 和 `13001:3001`，将容器内的端口映射到宿主机的端口。
* **shm_size**: 设置共享内存大小为 `2gb`。

部署：`docker-compose up -d`

访问地址：`http://127.0.0.1:13000/`,用户名：obsidian，密码：obsidian

> 注意：输入中文，需要在 kasmVNC 的设置中启用 `本地输入法`

如果你在使用 webdav,这个 docker-obsidian 的方案绝对值得一试。