---
comment: true
draft: false
modified: 2025-02-22 23:02:61
title: 用 Miniflux 极简 RSS 手撕信息茧房
aliases: [用 Miniflux 极简 RSS 手撕信息茧房]
tags: [RSS]
created: 2025-02-15T21:02:00
updated: 2025-03-02T19:50:53
---

# 用 Miniflux 极简 RSS 手撕信息茧房

> 🔖 Miniflux 是一款极简主义、开源且自托管的 RSS 阅读器，专注于高效信息聚合与隐私保护，支持多平台订阅和全文抓取。

把时钟拨回 2010 年，那时我们用 Google Reader 吃百家饭，如今算法却把我们绑在食堂窗口硬塞预制菜——左边短视频糖衣炮弹，右边标题党满汉全席，中间还插播 AI 推荐的 " 你可能想看的马桶测评 "。
这时候 Miniflux 举着 RSS 火炬从天而降：" 电子斋戒了解一下？没有卡路里过剩的信息流，只有你亲手挑选的思维食粮！"
![[rss-miniflux-1739954806293.jpeg]]
说正经的，这个通体不足 10MB 的数字修道院，能帮你实现三大自由：

1. 信息减肥自由
2. 隐私守护自由
3. 不被 AI 饲养员投喂自由。

接下来请系好安全带，我们要开始一场反算法叛逃行动…

## 项目速览

* 🌐 **官方地址**：[github-miniflux-v2](https://github.com/miniflux/v2) 
* 👨 **维护现状**：7.3k star , 活跃维护，版本迭代稳定（最新版本 v2.0.41）
* 📌 **核心价值**：
    * **隐私至上**：自动屏蔽广告与跟踪器，无数据转售；
    * **高效阅读**：键盘快捷键操作、全文抓取、多设备同步；
    * **极简设计**：静态编译无依赖，安装仅需单个二进制文件或 Docker 镜像。

> Miniflux 有三种阅读入口：阅读摘要 ，抓取原文，跳转原文

阅读时配合 ` obsidian web clipper` 可一键同步 markdown 到本地 `obsidian`。
![[rss-miniflux-1739799671971.jpeg|700x617]]

## 场景定位

### 推荐人群

* **信息极简主义者**：反感信息流算法干扰，追求纯净阅读体验；
* **RSS 重度用户**: Innoreader / feedly 用户可以看过来；
* **技术爱好者**：需自建服务、集成 Fever API 或搭配 RSSHub 扩展订阅源 ；
* **隐私敏感者**：拒绝广告跟踪，需本地化数据存储。

### 慎入情况

* **技术小白**：仅支持 PostgreSQL，需额外配置；
* **功能需求复杂者**：交互简洁, 无原生移动端、社交分享功能较弱。

## 技术透视

### 技术架构

1. **语言与框架**：基于 Go 语言开发，无外部依赖，轻量高效 910；
2. **数据存储**：强制依赖 PostgreSQL ≥9.5，支持 Docker 容器化部署 710；
3. **扩展能力**：提供 Fever API、JSON-RPC 接口，支持与 Pinboard 等工具集成 39。

### 设计哲学

1. **少即是多**：仅保留核心功能（订阅、分类、阅读），拒绝冗余交互 12；
2. **用户主权**：数据完全自控，无云端同步强制绑定 910。

> Miniflux 有强大的阅读生态集成

可以根据需要配置集成，将 rss 阅读同步过去，实在没有的，自己实现一个 `rest接口`，用 `webhook` 集成即可。

> 这种一切皆有可能的开源产品是真香！

![[rss-miniflux-1739799831803.jpeg|721x1161]]

## 实战指南

### Miniflux 服务端

使用 Docker Compose 快速部署

```yaml
version: '3'
services:
  miniflux:
    image: miniflux/miniflux:latest
    ports:
      - "8080:8080"
    environment:
      - DATABASE_URL=postgres://miniflux:密码@db/miniflux?sslmode=disable
      - CREATE_ADMIN=1
      - ADMIN_USERNAME=admin
      - ADMIN_PASSWORD=管理员密码
    depends_on:
      - db
  db:
    image: postgres:14
    environment:
      - POSTGRES_USER=miniflux
      - POSTGRES_PASSWORD=密码
    volumes:
      - ./data:/var/lib/postgresql/data
```

 * 启动命令: `docker-compose up -d`
 * 首次运行需执行数据库迁移命令 `docker exec -it 容器名 /usr/bin/miniflux -migrate`

### Miniflux 客户端

> android 版本

1. [Fluent Reader](https://github.com/yang991178/fluent-reader-lite)
2. [FeedMe](https://github.com/seazon/FeedMe)
3. [Read You](https://github.com/Ashinch/ReadYou)

上面几个, ReadYou 的界面,最美,可是我连接 nas 的 FeverApi 有点卡,只好用 Fluent Reader, 不过 android 版本的 Fluent Reader, 也很丝滑.
![[rss-miniflux-1740136299117.jpeg|265x523]]

手机端 FluentReader，我是通过 `fever` 接口集成的，参考 [miniflux-fever](https://miniflux.app/docs/fever.html) 配置

## 深度评测

* 用过商业的 Inoreader，feedly，需要科学上网，偶尔网络还卡影响体验；
* 搭建过开源的 Fresh RSS，Tiny Tiny RSS，蚁阅，要么界面不太考究，用着难受，毕竟和 `feedly` 还是有差距，外部集成的功能上扩展性做的也不够好。
* 最终找到我们的主角 `MiniFlux`,小巧玲珑，一切都刚刚好。

📌 **总结**
Miniflux 像一把瑞士军刀中的锋利刀刃——没有华丽装饰，但精准解决 `高效获取信息` 的核心需求。适合追求 `数字极简主义` 的硬核用户。

正如网友所言：" 用它之后，我终于找回了阅读的主动权。"
