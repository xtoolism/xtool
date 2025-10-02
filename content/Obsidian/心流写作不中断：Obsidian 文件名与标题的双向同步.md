---
title: 心流写作不中断：Obsidian 文件名与标题的双向同步
description: 本文将分享一个“神器组合”：Linter + Filename Heading Sync，帮你轻松实现文件名、一级标题、元数据三者的双向自动同步。告别重复劳动，让你的知识管理如丝般顺滑，写作心流不被打断。
tags: [Obsidian, Obsidian社区插件]
created: 2025-07-27T17:33:21
updated: 2025-07-31T08:51:31
---
![[file-20251002111847305.png]]

# 心流写作不中断：Obsidian 文件名与标题的双向同步

你是否也曾陷入这样的循环：在 Obsidian 中，命名了一个 `xxx.md` 文件，写下 `# h1` 标题，又在元数据里加上 `title` 字段。可一旦灵感涌现，想换个更贴切的名字，就得手动修改三处地方。这个过程很繁琐，会打破我们的沉浸式写作。

## obsidian 笔记有三种标题

### 文件名（title.md）
- 系统级唯一标识。
- 用于 `[[链接]]` 和文件搜索。
- 推荐简短明确。

### 2. 一级标题（# H1）
- 页面中可视化标题。
- 阅读时最先看到。
- 可更丰富、有语义。

### 3. YAML 元数据 -title 字段
- 给插件或查询用的结构化标题。
- 常用于 Dataview、发布等场景。
- 可与文件名或 H1 不同，但建议保持一致避免混乱。

保持文件名、H1 标题和元数据 `title` 的一致性，不仅是为了美观，更是为了笔记链接、搜索和发布的准确性。

今天，我将分享我的解决方案，通过两个插件的精妙配合，让这三者实现 `双向奔赴`，从此告别手工修改的烦恼。

## linter 配置
`Linter` 是一个强大的笔记格式化工具，提供了丰富的规则对标题，列表，YAML 元数据,Markdown 内容的自动格式化。

在这里，我们利用它实现从**文件名到内容**的自动化。当你的文件名修改后，Linter 会自动帮你处理好笔记内部的标题和元数据。

linter 配置自动生成元数据:`title` 字段

![[file-20251002111847485.png]]

linter 配置自动生成一级标题
![[file-20251002111847653.png]]

## Filename Heading Sync
linter 支持配置文件名改动后，自动修改一级标题和元数据标题。但是不支持在一级标题修改后自动修改文件名，这个时候就需要 `Obsidian Filename Heading Sync` 插件。

- 插件名称: Obsidian Filename Heading Sync
- 社区安装：
	- obsidian://show-plugin?id=obsidian-filename-heading-sync
- 项目地址:
	- https://github.com/dvcrn/obsidian-filename-heading-sync

配置 FileOpen 和 FileSave 的 Hook，保存和打开时候自动同步文件名和一级标题
![[file-20251002111847999.png]]

## 总结

回顾一下我们的工作流：

1. **修改一级标题** -> `Filename Heading Sync` 自动将改动同步到**文件名**。
2. **文件名变更** -> `Linter` 自动将新文件名同步到**元数据 `title`**。

通过 `Linter` 与 `Filename Heading Sync` 这对 `搭档`，我构建了一个全自动、无感知的同步工作流。

希望这个小技巧能为你扫除障碍，让你在 Obsidian 的世界里，心无旁骛，专注于思想的流动与知识的创造。

我是麦冬，我们下一篇「极客工具」分享再见。

**更多延伸阅读，按需探索：**
1. [Obsidian附件管理最佳实践](https://mp.weixin.qq.com/s/RXmbeZcucbDWbrDsm7Ah6A)
2. [剪藏网页内图片一键下载](https://mp.weixin.qq.com/s/bHR6HjNoKKIRRw-jQk0scw?token=1379247572&lang=zh_CN)
3. [一粘即用，Obsidian 网页链接快速排版术](https://mp.weixin.qq.com/s/_Q1x9yK9LuZhLXcI_Yrb2g)
