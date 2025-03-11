---
draft: false
title: Joplin 部署体验：对比 Obsidian 的文件透明性
aliases: 
tags:
  - Obsidian
created: 2025-03-03T18:48:10
updated: 2025-03-09T20:47:33
---
![[cover-poc-joplin.jpg]]
本文记录了 `Joplin Server` 的部署配置过程，包括服务端环境配置和客户端同步设置。虽然 Joplin 对 `Markdown` 的支持优于 `Evernote`，但其二进制存储格式不如 `Obsidian` 的文件系统`透明`。
对于需要直接访问和编辑服务端文件的用户来说，Obsidian 的文件管理方式更符合预期。
# Joplin 部署体验：对比 Obsidian 的文件透明性

## 部署服务端
官方安装文档： https://github.com/laurent22/joplin/blob/dev/packages/server/README.md

docker-compose.yml
```yaml
version: '3'

services:
  joplin:
    image: joplin/server:latest
    container_name: joplin
    network_mode: host
    volumes:
      - /mnt/github:/mnt/github
    environment:
      - STORAGE_DRIVER=Type=Filesystem; Path=/mnt/github/xtool/content
      - APP_BASE_URL=http://localhost:22300
      - APP_PORT=22300
    ports:
      - "22300:22300"
```

## 部署客户端
joplin-client下载地址： https://joplinapp.org/help/install

配置同步
![[joplin-client.png]]

测试了下，同步后的存储在本地的格式是二进制，比如下面的，没法人眼看，不是面向人的 markdown 文本格式

```c
├── t6
│   └── op
│       └── t6opd5oQAjkPsltaWjA1u0
├── te
│   └── st
├── ur
│   └── 4q
│       └── Ur4qFEOJtKpZRAFydPJURY
├── v7
│   └── tn
│       └── V7tn7FRm7ygxmpIZpPIiMh
```

我需求是建设自己长期知识库，数据都挂一个目录内，笔记可以直接在服务端查看和编辑。

上周末在找方案，体验了下joplin server，交互和 evernote 类似，对 markdown 的支持也更好，能方便的导入导出。
but 和 obsidian 这类相比，joplin 还是不够透明, 这样的二进制格式让用户以后只能依赖joplin，就算能导出，迁移成本也很高。

之前一直期望obsidian出个 web 版本的，后来就无意发现了[obsidian-docer](https://mp.weixin.qq.com/s/VECma6U5XE8YKWObov4QsQ)，可以让浏览器随时访问Obsidian 个人知识库，真是一探索就惊喜。

## 总结
Joplin 虽然是一个优秀的笔记系统，但它的存储方式确实不够透明。
Obsidian 的文件系统方式更符合程序员的使用习惯，因为：
1. 直接使用纯文本 Markdown 文件存储，可以使用常规文本工具进行处理
2. 文件系统结构清晰可见
3. 方便版本控制（如 Git）

目前 Obsidian 确实没有官方的 Web 版本。不过有一些第三方解决方案可以考虑：
- 使用 Obsidian Git 插件进行同步
- 使用 Syncthing 等工具同步文件
- 搭建私有的 WebDAV 服务器
- 使用 [Quartz](https://mp.weixin.qq.com/s/bOny9mGBuCNgwMXG-3_D0A) 发布为静态博客

如果你和我一样暂时需要 Web 访问，也可以考虑一些其他开源的选择，比如：
- Hedgedoc（原 CodiMD）: https://github.com/hedgedoc/hedgedoc
- VNote： https://github.com/vnotex/vnote
- Trilium Notes: https://github.com/zadam/trilium
- [obsidian-docer](https://mp.weixin.qq.com/s/VECma6U5XE8YKWObov4QsQ)

这些工具都提供了 Web 界面，同时保持了较好的文件透明性。

在AI时代，这个`透明性`显得特别重要，我们可以用cursor之类的`ide`，让AI直接对文本文件进行修改，然后用git比较AI的修改内容，就好像你的搭档提交了一个commit让你来review。