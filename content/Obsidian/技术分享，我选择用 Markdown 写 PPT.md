---
title: 技术分享，我选择用 Markdown 写 PPT
description: 如何用 Markdown 配合 Obsidian Marp Slides 制作 PPT，解决了 Mermaid 图表与本地图片渲染问题。通过引入 Mermaid.js 与自动图床替换，导出 HTML 即可演示，避免繁琐排版，让内容创作更专注高效。
tags: [Obsidian, Obsidian社区插件]
created: 2025-08-12T21:31:36
updated: 2025-08-16T15:31:17
---

![[ppt_cover.png]]
# 技术分享，我选择用 Markdown 写 PPT

最近在团队内做了一次关系企业知识库构建的技术分享，由于不擅长写 PPT 去调样式，于是鼓捣了 `Markdown` 进行演示的方案，调研一番，发现 `Marp Slides` 插件基本满足需求，它让我用 `Markdown` 就完成了整个分享，不用去折腾 PPT 布局排版，过程中解决了 Mermaid 图表和本地图片渲染的问题，分享给大家。

## Obsidian 插件
Marpit 是一个优秀的 `Markdown` 演示文稿项目，而 `Obsidian Marp Slides` 插件则将它的能力无缝集成到了 `Obsidian` 中。

项目地址：
* Marpit : https://marpit.marp.app/
* MermaidJs： https://Mermaid.js.org/
* Mermaid 编辑器： https://Mermaid.live/edit

Obsidian 插件地址
* Obsidian Marp Slides: https://github.com/samuele-cozzi/obsidian-marp-slides
* Mermaid ： https://github.com/huterguier/obsidian-mehrmaid

通过 **Mermaid**，我们不用专门的流图工具（例如：微软 Visio），我们需要编辑的只是文本，当今的大模型都特别擅长制作 Mermaid 图表的。

## 主要解决的 2 个问题
### Mermaid 图表渲染问题
Marp 社区的 [Mermaid Integration](https://github.com/orgs/marp-team/discussions/207) 的讨论很热烈，但是官方没有支持：可通过在 markdown 文本中引入 `mermaid.min.js` 解决，具体见后续模板。

实测时 `Export HTML` 可以渲染 Mermaid，`Export PPTX` 没搞定。
使用导出的 html 在浏览器中即可演示，和 ppt 效果基本一致！

![[file-20251002111848233.png|684x301]]

### 图片渲染问题

`Obsidian` 用户习惯使用 `![[image.png]]` 这样的 `Wiki` 链接格式来引用图片，但 `Marp` 只认标准的 `CommonMark` 格式，即 `![alt](path)`。直接使用 `Wiki` 链接会导致导出时图片丢失。

我的解决方法是配合 `image upload Toolkit` 这类插件，**在写作时就将本地图片自动上传到 OSS 图床，并替换为在线链接**。这样保证了 `Marp` 导出 HTML 中的图片可直接查看。

## 解决方案
### Mermaid
默认的 Html Export Mode 为 `bare.js`，需要改为 `bespoke.js`

### 插件配置
![[file-20251002111848351.png|819x669]]

### marp 导出 ppt 模板

```markdown
---
marp: true
paginate: true
size: 4k
theme: kbase
backgroundImage: url('https://unsplash.com/photos/gray-concrete-road-between-brown-and-green-leaf-trees-at-daytime-5hvn-2WW6rY')
---
 <script type="module">
 import Mermaid from 'https://cdnjs.cloudflare.com/ajax/libs/Mermaid/10.4.0/Mermaid.min.js';
 Mermaid.initialize({ startOnLoad: true });
 </script>

# 测试PPT

---

## Page1

---

## Page2

---

```

### 自定义样式模板
`theme: kbase` 是 指在 `ThemePath` 目录内从 css 文件:`kbase.css`，可自己定义表格标题等样式

```css
/* @theme kbase */

@import 'default';

section {
}


table {
    height: 100%;
    width: 100%;
    font-size: 18px;
}

th {
    font: bold;
}

a:hover, a:active, a:focus {text-decoration: none;}

```

其他官方主题见:
https://github.com/marp-team/marp-core/tree/main/themes

## 总结
用 Markdown 写 PPT 这次算是探索并实践了。不用专门去花大量精力制作花哨的 PPT 布局和动画。可以将时间用来专心写好内容。

这次也尝试将写好的 markdown 让 `skywork ai` 转 ppt，但是效果还是不太行，看着很炫，实则漏洞百出，不能拿来即用。
不过这并未动摇我对 `Markdown` 作为内容基石的信心。恰恰相反，它让我更加笃定，**一个结构化、逻辑清晰的纯文本文档，就是未来最高效的内容资产**。

我们可以想象，当 AI 智能体足够成熟时，我们只需专注于产出结构化程度够高，细节够丰富的笔记。到时候一篇笔记便可按需产出图文、视频、演示稿等格式的内容。

我想，那一天，值得我们期待。
