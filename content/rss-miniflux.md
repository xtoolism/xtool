---
comment: true
title: 极简 RSS 信息聚合工具之 Miniflux
created: 2025-02-15 21:02:00
modified: 2025-02-20 20:02:34
tags: [RSS]
draft: false
---

# 极简 RSS 信息聚合工具之 Miniflux
>  🔖 Miniflux 是一款极简主义、开源且自托管的 RSS 阅读器，专注于高效信息聚合与隐私保护，支持多平台订阅和全文抓取。  
![[rss-miniflux-1739954806293.jpeg]]
## 项目速览
* 🌐 **官方地址**：[github-miniflux-v2](https://github.com/miniflux/v2) 
* 👨 **维护现状**：7.3k star , 活跃维护，版本迭代稳定（最新版本 v2.0.41）
* 📌 **核心价值**：
    * **隐私至上**：自动屏蔽广告与跟踪器，无数据转售；
    * **高效阅读**：键盘快捷键操作、全文抓取、多设备同步；
    * **极简设计**：静态编译无依赖，安装仅需单个二进制文件或 Docker 镜像。  

强大的阅读生态集成  
![[rss-miniflux-1739799831803.jpeg|492x792]]

在线阅读  
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

### 学习曲线
* **配置复杂度评级**：⭐️（Docker 部署一键完成）
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

## 深度评测

| 阅读器               | 功能特点             | 速度表现                     | 颜值设计       | 上手难度          | 价格策略    |
| ----------------- | ---------------- | ------------------------ | ---------- | ------------- | ------- |
| **MiniFlux**      | 轻量高效/多用户支持       | 极快（Persisted Storage 加速） | 极简风格/内容聚焦  | 极易（一键部署）      | 免费开源    |
| **Tiny Tiny RSS** | 主题定制/社交分享        | 中等（依赖服务器优化）              | 原生粗糙/需手动美化 | 中等（需配置）       | 免费开源    |
| **Fresh RSS**     | 响应式设计/缓存优化       | 较快（智能缓存机制）               | 清新现代/主题可选  | 中等（Docker 部署） | 免费开源    |
| **Inoreader**     | 离线阅读/智能过滤/OCR 识别 | 云端加速（大规模优化）              | 功能密集/界面拥挤  | 极易            | 分免费和收费版 |

📌 **总结**  
Miniflux 像一把瑞士军刀中的锋利刀刃——没有华丽装饰，但精准解决 " 高效获取信息 " 的核心需求。适合追求「数字极简主义」的硬核用户，

慎入者亦可尝试 Docker 版浅尝辄止。  
正如网友所言：" 用它之后，我终于找回了阅读的主动权。"
