---
draft: false
title: obsidian-sync-livesync
aliases: [obsidian 多端同步 -livesync, Obsidian 多端同步 -LiveSync, 我的同步场景, 环境准备]
tags: [Obsidian]
created: 2025-03-03T19:25:43
updated: 2025-05-10T09:59:38
---
![[obsidian-sync-livesync.jpg|841x473]]

# Obsidian 多端同步 -LiveSync
# 我的同步场景
同步节点
* 服务端：NAS
* 客户端：PC
* 客户端：手机
* 客户端：Chrome 浏览器（弱需求）

同步需求
1. 手机随时记录闪念，服务端能自动同步；
2. PC 新增/更新笔记，服务端能自动同步；
3. 手机和 PC 有冲突时能提示解决；
4. 同步数据要求支持端到端加密，保证数据安全；
5. 同步服务能稳定运行，不能占用手机太多资源

## 踩过的坑
之前的折腾：
1. 尝试 `sycthing` 也有上述问题，很不稳定。
2. 尝试 `mgit`，使用纯 git 同步，但是手机端 `mgit` 经常挂没法同步；
3. 尝试过 `webdav`，PC 同步到 NAS 的 webdav，然后手机使用 `autosync` 同步,这个方式是最简单粗暴，但是不知道自己当时遇到啥问题，也是放弃了；

目前 livesync 虽然目前在用，勉强满足需求，但是很多坑：
1. 手机端偶尔会和服务器不一致，得重新同步才能恢复，我笔记大概有 500M，手机全刷一遍太慢了，只能到有 wifi 的地方才能干；
2. couchdb 服务挂过几次导致没法同步；
3. 有时手机随便点了下，linter 格式化了，失误覆盖了 PC 端的修改；

具体 livesync 安装过程分享给大家，有需要的可以尝试下，搞不好就很适合少年你的体质。

# 环境准备
依赖环境
1. couchdb 服务：一个数据库服务软件，一款基于 JSON 文档的分布式数据库；
2. obsidian live sync 插件：obsidian 插件，注重安全，支持端到端加密；
3. 假设你有一个 NAS/ECS，并申请了公网域名：示例域名为：localhost

## 安装 couchdb
使用 docker-compose 部署

```yml
version: "3.2"
services:
  couchdb:
    image: couchdb
    container_name: obsidian-livesync
    environment:
      - COUCHDB_USER=admin
      - COUCHDB_PASSWORD=yourpassword
    volumes:
      - /mnt/mind/data/couchdb/data:/opt/couchdb/data
      - /mnt/mind/data/couchdb/local.ini:/opt/couchdb/etc/local.ini
    ports:
      - 5984:5984
    restart: unless-stopped
```

数据库配置：`local.ini`

```c
[couchdb]
single_node=true
max_document_size = 50000000

[chttpd]
require_valid_user = true
max_http_request_size = 4294967296

[chttpd_auth]
require_valid_user = true
authentication_redirect = /_utils/session.html

[httpd]
WWW-Authenticate = Basic realm="couchdb"
enable_cors = true

[cors]
origins = app://obsidian.md,capacitor://localhost,http://localhost,http://你的域名
credentials = true
headers = accept, authorization, content-type, origin, referer
methods = GET, PUT, POST, HEAD, DELETE
max_age = 3600
```

1. 访问 couchdb 后台页：`http://localhost:5984/_utils` , 输入帐号 (admin) 密码 (yourpassword) 后进入管理页面
2. 新建数据库，比如：obsidian
3. 启用 CORS: http://localhost:5984/_utils/#_config/nonode@nohost/cors

## 安装 obsidian-livesync 插件
安装 obsidian-livesync 插件：[下载地址](obsidian://show-plugin?id=obsidian-livesync)

### PC 端配置
配置同步服务器：填写 URI：`http://localhost:5984`，用户名，密码，执行 test 后无误，apply 即可。
![[obsidian-livesync-obsidian-livesync-config-pc-1-20250303.png|812x977]]
为了安全，开启端到端加密，千万记好加密的密码，不然数据谁都解不开。
这样数据会用这个 key 加密后传输到云端，服务器被攻击，别人拿到了你的数据也没有办法。

> 同步策略配置
![[obsidian-livesync-obsidian-livesync-obsidian-livesync-config-pc-2-20250303.png|812x946]]

> 配置好后，可以在 Setup 页，`Copy the current settings to Setup URI`,输入密码加密分享 URI。

![[obsidian-livesync-1-20250303.png|812x409]]

### 手机端配置
在手机端也安装 livesync 插件

![[obsidian-livesync-Screenshot_20250303_222536_md.obsidian-20250303-2.png|488x1080]]

点击 `Connect with Setup URI`，输入刚才复制的 URI，就可以开启同步了。
![[obsidian-livesync-Screenshot_20250303_222628_md.obsidian-20250303.png|488x1080]]

![[obsidian-livesync-Screenshot_20250303_222647_md.obsidian-20250303.png|488x1080]]

📌 总结
本文介绍了 obsidian 的 livesync 来实现多端同步，配置比较简单，但是这个插件有很多特性,也适合深入使用，比如：livesync 新出的点对点 P2P Replicator 模式（点对点同步架构）就等着我去折腾

最近还了解到 [[trilium知识库-数据同步测试]] 的方案，生命不息，折腾不止。相信我总能从开源社区里面找到一条适合自己的方案。
