---
title: 我用 Copilot 写代码，也用它写文章
tags: []
created: 2025-06-30T11:39:43
updated: 2025-10-02T11:07:35
---

![[创建图片.png]]

# 我用 Copilot 写代码，也用它写文章

大家好，我是麦冬。

最近，AI 工具层出不穷，我也一直在求索最适合自己的 AI 写作流程。过程不可谓不折腾，尝试了市面上常见的几种方案：

- **浏览器 AI 服务**：比如 `DeepSeek`、`ChatGPT`、`Gemini` 等。虽然免费强大，但致命伤是无法直接与我的本地笔记联动。**在 `Obsidian` 和浏览器之间反复横跳，灵感早就被复制粘贴消磨殆尽**。
- **客户端 Agent**：尝试过基于 `VS Code` 的 `Cline` 插件，利用 Agent 生成初稿再修改。思路不错，但流程还是略显割裂。
- **Obsidian AI 插件**：像 `Infio Copilot`、`ChatGPT MD` 这类插件，本应是最佳选择。可现实是，大部分插件要么是个人作品，体验粗糙；要么依赖的免费模型响应慢如龟速，**写着写着就卡住或干脆没反应，稳定性堪忧**。

就在我快要放弃的时候，一个契机出现了。

## 柳暗花明：当 Copilot 遇上 Obsidian

最近，我在用 `Flutter` 开发 AI 问答日记的手机 App，开通了 `GitHub Copilot Pro` 订阅，便萌生了在 `Obsidian` 中使用 Copilot 的想法。因为 agent 写代码的能力真的是非常强，特别是 `claude sonnet 3.7` 版本，代码生成能力非常强。我基本不懂 flutter 的客户端开发，基于自己对需求的理解，全程是通过 copilot 的提示词指导 AI 进行开发，最终还是完成一个能满足自己需求的 AI 日记工具，能作为我的 Obsidian 移动端客户端的替代品。

所以我想能不能在 **Obsidian** 中使用 **GitHub Copilot** 来辅助写作呢？
经过一番探索，发现还真有个 `GitHub Copilot` 的 Obsidian 插件，这下 Obsidian 真变成我的写作 IDE 了。
真真真丝滑，特别是 AutoComplete 自动完成，毫无卡顿感，写作体验非常好。

# Obsidian Github Copilot 插件的视频演示

**演示内容**
1. 行内补全，候选切换;
2. 侧边栏对话
3. 基于本地笔记的对话
4. 对话历史查看

# AI 写作工具的探索过程

# 2 个核心功能
## 行内实时补全
在编辑器中输入时，GitHub Copilot 会根据上下文自动建议接下来的内容。

![[01Project/Blog/content/assets/{NoteName}/image.png]]
基于 sequential-thinking。分析 lib 目录内代码中关于 webdav 同步的逻辑，修复 bug，提升性能，使更模块化其实我也尝试了 **infio** 上的 autoComplete 模型，想基于 **OpenRouter** 的模型来白嫖，测试了下面的模型：
1. cognitivecomputations/dolphin3.0-mistral-24b:free
2. qwen/qwen-2.5-coder-32b-instruct:free
3. google/gemini-2.0-flash-exp:free

效果挺卡，也测试了 infio 官方的：`xai/grok3-fast-latest`，速度要好一点，但是延迟也有 1s 以上，有点卡的。

而 GitHub Copilot 的响应速度非常快 (**300ms** 左右)，几乎是即时的，体验非常丝滑。所以最后我选择关闭了 infio 的 autoComplete 模型，改用 GitHub Copilot 来辅助写作。

毕竟我已经订阅了 GitHub Copilot Pro，收费的服务体验更好，就先不折腾了，等哪天开源的 AutoComplete 模型能达到 GitHub Copilot 的水平，再来折腾。

## 基于本地笔记的对话
使用 `[[笔记名]]` 引用笔记，结合提示词进行总结或者扩写；
体验比 **infio** 差的太多了：不支持流输出，选择本地文件很卡。
优点是是可使用最先进的模型：`Claude Sonnet 4`、`Gemini 2.5 Pro`、`GPT 4.1` 等随意切换，体验慢就慢点吧，胜在效果好
![[01Project/Blog/content/assets/{NoteName}/image-1.png]]

# 使用 GitHub Copilot 辅助写作
# 写作体验
使用 GitHub Copilot 插件后，我的写作体验有了显著提升，主要体现在以下几个方面：
1. **行内实时补全**：当我输入一些关键词时，Copilot 能够智能地预测接下来的内容，减少了我输入的工作量。
2. **上下文理解**：Copilot 能够理解我当前的写作上下文，提供更相关的建议，使得写作更加流畅。
3. **内容生成**：在需要时，Copilot 能够生成完整的段落或句子，帮助我快速构建文章框架。

# 订阅 GitHub Copilot 服务
首先得有 GitHub 帐号，然后开通 GitHub Copilot Pro 订阅服务。
GitHub Copilot Pro 首月绑卡免费，但是我尝试自己的 VISA 卡绑不了，最后在淘宝买的代充服务，18 元先开通了，后续再续，官方 10 美元一个月。代充值大概多个 20 元的手续费。

# 安装 GitHub Copilot 插件
1. 打开 Obsidian 的设置，进入插件市场。
2. 搜索 `GitHub Copilot` 插件，或者到 github 下载
	1. https://github.com/Pierrad/obsidian-github-copilot
3. 点击安装并启用插件。
4. 在插件设置中配置 GitHub Copilot 订阅信息，需要输入 8 位数的动态验证码。

# 配置 GitHub Copilot 插件
配置 copilot server 的环境，依赖 Node 环境，设置智能提示的延时以及快捷键的绑定。
![[01Project/Blog/assets/{NoteName}/image.png]]

设置智能补全忽略的文件或者目录；
![[image-5.png]]

copilot 的提示词配置
![[image-6.png]]

## 写在最后

工具的意义，在于能让我们更专注于事情本身。`Obsidian` 与 `GitHub Copilot` 的相遇，对我而言，就是这样一次恰到好处的结合。

目前我的 AI 方案的一句话给大家参考：**GitHub Copilot** 实现智能补全，**Infio Copiliot** 实现 MCP 等智能体增强对话；

**更多延伸阅读，按需探索：**
1. [语义搜索的科普：king - man + woman ≈ queen](https://mp.weixin.qq.com/s/zzRXufk8-WQalbl8tXAsGw)
2. [构建个人知识库-十年知识管理的工具选型心得](https://mp.weixin.qq.com/s/PtWqkUWVNPIbx82A9tH-Xg)
3. [基于常青笔记方法论构建自己的知识体系](https://mp.weixin.qq.com/s/V5EvSfqldsJI47Oy3RcK8Q)
