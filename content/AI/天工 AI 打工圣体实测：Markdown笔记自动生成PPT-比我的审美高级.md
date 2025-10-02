---
title: 天工 AI 打工圣体实测：Markdown笔记自动生成PPT-比我的审美高级
aliases: [天工 AI 打工圣体实测：Markdown 笔记自动生成 PPT- 比我的审美高级]
tags: []
created: 2025-05-23T09:34:58
updated: 2025-10-02T11:06:18
---
![[file-20251002111757462.png]]
SkyWorkAI 是近期体验感颇佳的一款多模态智能体工具，它不仅支持任务分解、联网搜索，还能自动生成格式化演示内容。本文以「Obsidian 备份策略」为例，完整复盘了 SkyWorkAI 文档智能体的工作流程，并结合 MCP 协议的使用细节与图文演示，评测其真实能力和可拓展性。

# 天工 AI 打工圣体实测：Markdown 笔记自动生成 PPT- 比我的审美高级

在信息爆炸的时代，**真正属于自己的知识，不是收藏的链接，而是沉淀下来的思考与结构化笔记。**
我一直坚持用 Markdown 记录 Obsidian 笔记，构建个人知识库，不为排版、不为格式，只专注内容本身。

但在实际工作中，我们总免不了将这些纯文本内容转化成 PPT、方案、讲稿、邮件等。

`格式化输出`。`创作靠人脑，表达可交给 AI`。

最近我实测了一款办公智能体工具——**天工 SkyWorkAI**，它能自动识别我写好的笔记内容，生成结构清晰、图文并茂的演示文稿，甚至能拆解任务、联网搜索、协同生成。

这篇文章将完整复盘一个真实案例：从一份 Markdown 笔记开始，SkyWorkAI 如何一步步将其转化为一套完整的演示方案。

## 服务地址
SkyWorkAI 目前分为两个版本：
- **外网版**-SkyWorkAI： https://skywork.ai/home?invite_code=adc3071b8d34cfbfc85625480784f729
- **国内版（天工 AI）**： https://www.tiangong.cn/login?invite_code=b5fdaa92100f3321ce63a3efa34f6645

![[file-20251002111757616.jpg]]

## SkyWorkAI 文档智能体的实现流程
最近在测试多模态智能体工具时，我注意到 SkyWorkAI 的一个特点非常吸引人：**不只是"生成内容"，而是能一步步"完成任务"**，这与传统大模型不同，更像是个"能干事"的数码助理。
通过观察其生成日志，我梳理出了 SkyWorkAI 的基本执行流程：

### ✅ 1. 明确需求（Prompt 转换为任务）
我的输入内容是直接复制本地的 markdown 笔记，具体见：[Obsidian误删恢复有妙招！三重备份方案，让数据安全无忧](https://mp.weixin.qq.com/s/GEhSWA4QcB_CUIRqj8aXbg)

发送给 SkyWorkAI 后，它就自动识别任务目标，人工确认 plan 后，进入下一步。
![[file-20251002111757795.png]]

### 🧠 2. 自动生成 TODO 任务清单

SkyWorkAI 会拆解子任务，比如：

- 检索 Obsidian 备份方法
- 编排 PPT 页面结构
- 设计内容排版与样式

![[file-20251002111757932.png]]

### ⚙️ 3. 执行任务（多智能体并行协作）

任务会分配给不同"子智能体"，它们调用 MCP 接口完成具体操作：
- 🔍 联网搜索（调用 MCP 网络爬虫）
- 🌐 页面抓取（模拟浏览器行为）
- 💻 HTML PPT 编码生成（排版、配图一体完成）

整个过程像极了一个带团队的内容运营，分工明确，流程自动化。
![[file-20251002111758110.png]]
![[file-20251002111758241.png]]

生成的 PPT 效果还是不错的，布局，图文搭配的很好。
![[file-20251002111758433.png]]

生成的完整内容见：[天工 AI 打工圣体实测：Markdown笔记自动生成PPT-比我的审美高级](https://mp.weixin.qq.com/s/NH5cy_8Dbq8OEz__G8yhhQ)

## 总结
总的来说，SkyWorkAI 是目前少数**能真正"完成任务"而不是"答题"的 AI 工具**，比通用的 `Manus` 智能体在办公领域更专更强，适合用于文档生成、方案整理、演示稿初稿等场景。

我是麦冬，这是我的 AI 工具实践记录，如果你也对 Obsidian、个人知识管理、AI 生产力工具感兴趣，欢迎关注我在「极客工具」的更新。

**更多延伸阅读，按需探索：**
1. 本文测试输入的原文：[Obsidian误删恢复有妙招！三重备份方案，让数据安全无忧](https://mp.weixin.qq.com/s/GEhSWA4QcB_CUIRqj8aXbg)
2. 智能体调用的 MCP 是个什么东西？ 👉 [MCP协议解读](https://mp.weixin.qq.com/s/GuyMTblmHAHNlbRwXtdJGw)
3. 智能体生成的图片如何本地化管理？👉 [obsidian 附件管理的最佳实践](https://mp.weixin.qq.com/s/RXmbeZcucbDWbrDsm7Ah6A)
