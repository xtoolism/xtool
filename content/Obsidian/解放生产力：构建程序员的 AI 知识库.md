---
title: 解放生产力：构建程序员的 AI 知识库
description: 如何通过 obsidian-terminal 和 workspace 插件，将 Qwen-Coder 等 AI CLI 工具无缝融入 Obsidian，实现文件操作、AI 交互和内容创作的三合一，打造适合程序员的高效知识库
tags: [Obsidian, Obsidian社区插件, Terminal]
created: 2025-07-23T17:53:17
updated: 2025-10-02T11:12:08
---

![[file-20251002111851248.png]]

# 解放生产力：构建程序员的 AI 知识库

大家好，我是麦冬。
在上一篇 [《放弃白板，我用 Obsidian 工作空间打造知识库主页》](https://mp.weixin.qq.com/s/z7KovqMZ7fMCrweYSUrYtw) 中，刚分享了一个自己的 `Terminal` 场景。巧了，昨天 `Qwen-Coder3` 突然放大招，
我火速体验了一番，效果超乎预期。今天，就带大家看看这个新发布的 AI 助手，如何将这个强大的 AI CLI 无缝融入我们的 Obsidian 工作流。

## 为什么选择 Obsidian 作为程序员的知识库

个人真心觉得每个程序员都应该使用 Obsidian 作为个人知识库，尤其是 `DevOps`/`SRE` 这类天天和 Terminal 打交道的工程师，理由很简单：

### Terminal 的高效和广泛

命令行是程序员的母语。Obsidian 通过 `obsidian-terminal` 这类插件，完美地将终端集成到了知识库内部。你不再需要在编辑器和外部终端之间频繁切换。编译代码、运行脚本、管理版本，一切操作都可以在你记录笔记的同一个地方完成。这种沉浸式的体验，让知识的输入、处理和输出流程合一，效率倍增。

![[file-20251002111851430.png]]

### Markdown 语法，专注内容

我们是内容的创造者，而非格式的奴隶。Obsidian 采用纯粹的 Markdown 语法，让你能够专注于文字和逻辑本身，不必为排版和样式分心。所有文件都是本地的纯文本，这不仅带来了极致的安全感和掌控感，也方便使用 `git` 进行版本管理，或用 `grep`、`sed` 等命令行工具进行批量处理。

归根结底，Obsidian 能让你实现自动化。**懒**是程序员的美德，任何手动重复的工作，在 Obsidian 里面都可以考虑自动化处理，而且都能找到实现方案！这样的开放性是其他工具做不到的。

### 按最新技术不断涌现的插件

Obsidian 的核心魅力在于其强大的社区和插件生态。无论是最新的 AI 技术、代码高亮工具，还是项目管理看板，你几乎总能找到一款插件来满足需求。这意味着你的知识库永远不会过时，它能与你的技术栈同步进化，这是一种 `活` 的知识管理方式。

## 在 Obsidian 里面基于 qwen-code 打造个人 AI CLI

![[file-20251002111851687.png]]

当 AI 成为标配，我们如何以 `程序员的方式` 使用它？带界面的 `copilot` 之类的 Chat 应用虽然直观，但对于追求极致效率和自由度的我们来说，命令行（CLI）或许是更优解。它更轻、更快，对文件的操作也更直接。

这里，目前在测试**qwen-code**打造我的个人 AI CLI，多窗口的话基于**tmuxp**，可以任意多开 n 个 terminal。

- **qwen-code 项目地址**：[https://github.com/QwenLM/qwen-code](https://github.com/QwenLM/qwen-code)

qwen-code 是基于 `gemini cli` 开发的，非常符合国人的网络使用环境和习惯。特别是配合最先进的编码大模型 `Qwen3-Coder`: Agentic Coding in the World，吊打闭源模型。

> **Qwen3-Coder-480B-A35B-Instruct**
 a **480B**-parameter Mixture-of-Experts model with
 **35B** active parameters which supports the context length of
 **256K** tokens natively and **1M** tokens with extrapolation methods

![[file-20251002111851783.png]]

> 可惜没有那么大的卡可以随心所欲的跑，本地起码 80G 以上才能玩，云服务又有 token 限制。不然我真要放飞自我全程写设计文档，让 agent 干活了。

## 终端知识库：插件的化学反应

通过 `obsidian-terminal` 插件（`obsidian://show-plugin?id=terminal`）和 `workspace` 核心插件，我们可以让个人知识库变身为一个强大的 `终端知识库`。

1. **终端输出，无缝衔接**：在终端窗口中运行 AI 命令，无论是代码片段、分析报告还是文章润色，其输出都可以被随时复制，甚至直接通过管道符 `>` 或 `>>` 写入到知识库内的任一 Markdown 文件中。这打通了 AI 生成内容与知识沉淀之间的 `最后一公里`。
2. **AI 驱动，编辑万物**：借助 AI 的能力，我们可以直接在命令行中对知识库的 `.md` 文件进行编辑。比如，你可以写一个简单的脚本，让 AI 帮你总结某篇长文、翻译某个段落，或者根据你的大纲自动扩写，并将结果保存。

![[file-20251002111852027.png]]

## Workspace 插件：多线程工作的艺术

Obsidian 的 `workspace` 插件是这个工作流的关键。它允许你保存和加载自定义的窗口布局。

想象一下这个场景：
- **左侧窗口**：一个标准的 `bash` 终端，你在这里用 `ls`, `cd`, `mv` 等命令自如地操作文件系统，管理你的项目。
- **右侧上方窗口**：一个 `qwen-code` 的 AI 对话窗口，你在这里调用 AI 进行头脑风暴、辅助写作或调试代码。
- **右侧下方窗口**：一篇正在编辑的 Markdown 笔记，AI 生成的内容可以被瞬间应用到这里。

这种分屏操作，将文件管理、AI 互动和内容创作融为一体，让你仿佛拥有了一个高度集成的个人开发与写作环境。我个人最常用的是 `aichat` 命令，它不需要复杂的界面渲染，在终端中流式输出的体验，甚至比很多网页端还要流畅。

# 其他优秀的 AI CLI 工具

在 CLI 工具的选型上，我们应该务实一点，不搞情怀，谁好用、谁优秀就用谁。除了 qwen-code，市面上还有其他值得关注的 AI CLI 工具。

## gemini-cli
- **项目地址**：[https://github.com/google-gemini/gemini-cli](https://github.com/google-gemini/gemini-cli)
- **特点**：Google 出品，如果你能顺畅访问 Google 的服务，Gemini 的模型能力和多模态支持非常强大，值得一试。

## aichat

- **项目地址**：[https://github.com/sigoden/aichat](https://github.com/sigoden/aichat)
- **特点**：极其简洁，是我日常作为临时 AI 对话的首选。它的配置简单，响应迅速，没有多余的功能，纯粹为了对话而生，非常适合快速查询和获取灵感。

## auto-coder

- **项目地址**：[https://github.com/allwefantasy/auto-coder](https://github.com/allwefantasy/auto-coder)
- **特点**：国内开发者祝威廉的作品，功能非常强大和完善。它不仅仅是一个聊天工具，更是一个自动编程框架。
    - `auto-coder.chat` 模式非常适合有技术背景的用户，可以深入地进行代码相关的对话和任务。
    - `auto-coder.web` 模式则提供了一个 Web 界面，更适合非技术背景的用户使用。

## 总结
从最初的双链笔记，到如今内嵌终端与 AI 的助手引擎，我不断重塑的不仅是工具，更是自己的工作流。这套方法的核心是：用最直接的方式，将思考付诸实践。

放弃那些花哨的界面和封闭的生态吧。拥抱 Markdown 的纯粹、终端的效率和 AI 的智慧，在 Obsidian 这片开放的土地上，打造真正属于你自己的、独一无二的思考利器。希望这篇文章，能为你打开一扇通往新世界的大门。

**更多延伸阅读，按需探索：**
1. [构建个人知识库-十年知识管理的工具选型心得](https://mp.weixin.qq.com/s/PtWqkUWVNPIbx82A9tH-Xg)
2. [轻松做好周总结：PDCA 循环 + Obsidian 自动化工作流](https://mp.weixin.qq.com/s/VuuMaA73jeNYHaD-X1toCw)
3. [Periodic Notes：知行合一，从日记开始](https://mp.weixin.qq.com/s/fh-3geUNhPhoTe-62MtatQ)
