---
model: openrouter@deepseek/deepseek-chat-v3-0324
title: Obsidian AI 最佳实践：OpenRouter 零门槛整合 90+ 大模型
aliases: [Obsidian AI 最佳实践：OpenRouter 零门槛整合 90+ 大模型]
tags: []
created: 2025-04-19T12:19:09
updated: 2025-10-02T10:46:54
draft: true
---
![[file-20251002111754620.png]]
还在手动切换 AI 平台处理笔记？`Obsidian+OpenRouter` 黄金组合帮你本地无缝调用 Claude、GPT-4 等 93+ 大模型。5 分钟配置即可实现：跨模型工作流自动衔接、可视化参数调节、`免费额度` 薅羊毛，还能 `绕过地域限制`。
配合 `chatgpt-md` 插件，对话记录直接嵌入 Markdown 笔记，知识管理效率翻倍。文末附赠 `个人AI插件踩坑记录`，教你打造专属智能知识库。

# Obsidian AI 最佳实践：OpenRouter 零门槛整合 90+ 大模型
作为 Obsidian 的深度笔记用户，你是否也面临这些痛点？
- 每次整理完笔记，需要 `跳转切换` 第三方平台才能调用 AI 进行摘要分析？
- 想体验 Claude/GPT-4 等顶尖模型，却 `受限于网络` 访问障碍？
- 配置 ObsidianAI 插件时，总需要查阅不同的 API 文档，确认模型名称？
- 模型切换必须手动修改配置，连 temperature/top_p 等 `核心参数` 都无处调整？

今天带来新的解决方案：通过 OpenRouter 网关，您可以在 Obsidian 中：
✓ 集成 47+ 主流 AI 服务厂商（Google/OpenAi/DeepSeek/Ollam 等）
✓ 一键调用 93+ 主流大模型（GPT-4/Claude/DeepSeek 等）
✓ 免除地域限制和 API 密钥管理的烦恼
✓ 可视化调整所有对话参数
✓ 实现真正的跨模型工作流无缝衔接

下文将详解如何用 5 分钟搭建您的全能 AI 知识助手，一起高效。

# 大模型的使用方法
1. **App**或**网站**: 很多国产大模型 App（如豆包、Kimi）提供完全免费服务。部分国外产品（如 OpenAI 和 Gemini）也有次优模型的免费试用，但需要解决 kx 上网问题。
2. **API**集成大模型接口，在大模型云服务，注册新增 API 密钥即可；

## API 调用大模型的好处
APP 适合普通用户，API 提供了更多灵活性和功能，适合需要深度定制化的用户。
1. API 可与工作流深度集成，支持自动化任务。
2. 提供更大的输入上下文窗口，克服 App 的输入限制。
3. 便于无缝切换不同模型，提升灵活性。

## 我用 API 大模型做什么
1. 为日记/笔记内容生成总结
2. 初学一个不熟悉的领域时，初始化一个知识图谱，然后自己再对每个点进行深入；
3. 使用结构化方式重构我凌乱的口语表达
4. 对输出内容提供修改意见

## 常用的大模型 API 服务商
1. **OpenRouter**
   - 特色：模型种类丰富，涵盖商用和开源选择。
   - 注意：免费额度相对有限，仅部分模型标注 "free" 字样。
2. **Siliconflow**(硅基流动)
   - 特色：提供免费的 Qwen、gemma 和 SD（文生图）系列模型。
   - 优点：国内用户可直接访问，无需 kx 上网。
3. **Google-AI-Studio**（需 kx 上网）
   - 特色：提供自家最先进的模型（如 Gemini 系列），每日可享受 1500 个免费请求，最大限速为每分钟 100 万 token 和 15 个请求。
   - 优点：个人用户通常享有永不失效的额度。
4. **groq**（需 kx 上网）
   - 特色：支持 llama 系列和 gemma 系列，大部分模型每日提供 500k tokens 的免费额度。

## 如何免费使用大模型 API
本文重点教大街如何使用 **Openrouter** 来薅资本主义羊毛，上面的服务商都能访问。
OpenRouter 是一个大模型 API 路由器，旨在将各种 AI 模型服务 `集成到统一的接口` 中。
OpenRouter 降低了 AI 技术的使用门槛，让更多人能够轻松地 `选择合适的大模型` 解决实际问题。

### Openrouter 的模型排行
模型 token 排名：
https://openrouter.ai/rankings

可以通过大模型调用的 token 排名，选择最优的模型试用
![[file-20251002111754797.jpg]]

### Openrouter 免费使用限制
- **免费模型版本**: 仅限于 ID 以 :free 结尾，每分钟最多 20 次请求。
- **余额低于 $10**: 每日请求限制为 50 次。
- **账户余额高于 $10**: 每日请求限制增加至 1000 次。

### Openrouter 集成第三方服务商的模型
集成地址:
https://openrouter.ai/settings/integrations

比如我集成了 `Google AI Studio`，`groq`，`Anthropic`，这些服务商都有免费的额度，且能避开 kx 上网
当然还有国内的 `DeepSeek`，也是又便宜又好。

配置开启 `user this key as a fallback`，达到速率限制或者失败会优先使用自己 `Api Key`
![[file-20251002111754983.jpg]]

## 在 Obsidian 里面如何丝滑的使用 AI
### Obsidian AI 插件
- 插件 ID: **chatgpt-md**
- 项目地址: https://github.com/bramses/chatgpt-md
- 项目描述: 让 ChatGPT 与 Obsidian 的（几乎）无缝集成。
- 支持配置 3 类模型：每个 AI 服务现在在设置和元数据中都有自己的专用 URL 参数
	- openaiUrl 用于 `OpenAI` API
	- openrouterUrl 用于 `OpenRouter.ai`
	- ollamaUrl 用于 `Ollama` 本地模型
- 特性：
	- 按提示词模板创建笔记
	- 使用 yaml 参数作为大模型参数，可以通过指令修改从在线列表切换大模型
	- 对话记录以 role:user 和 role:assitant 的形式存储在笔记中

### chatgpt-md 使用示例
ctrl+p，切换模型
![[file-20251002111755117.jpg]]

在模型列表过滤 deepseek
![[file-20251002111755300.jpg]]

> 可参考 openrouter 的模型排行选择模型

### chatgpt-md 快捷启动
只需几个简单步骤即可开始：
1. **安装 ChatGPT MD**：前往 `Settings > Community Plugins > Browse` ，搜索 `ChatGPT MD` 并点击  `安装` ;
2. 在 openrouter 网站新增 1 个 api key;
3. **添加 OpenAI API 密钥** ：在插件设置中添加 OpenAI API 密钥，或安装 Ollama 以及您选择的本地 LLMs;
4. **开始聊天** ：使用 `ChatGPT MD: Chat` 命令 (`cmd + p` 或 `ctrl + p`) 从任何笔记开始对话。
![[file-20251002111755463.gif]]

### 调整大模型的生成参数

> 普通用户使用默认参数即可

使用笔记头部的 yaml 参数作为大模型参数，可以通过指令修改从在线列表切换大模型

```yaml
---
system_commands: ['I am a helpful assistant.']
temperature: 0.3
top_p: 1
max_tokens: 4096
presence_penalty: 0.5
frequency_penalty: 0.5
stream: true
stop: null
n: 1
model: openrouter@deepseek/deepseek-chat-v3-0324

# Service-specific URLs (optional, will use global settings if not specified)
openaiUrl: https://api.openai.com
# openrouterUrl: https://openrouter.ai
# ollamaUrl: http://localhost:11434
```

## Obsidian AI 插件比较
下面是我在 obsidian 使用过的 AI 插件：
1. copilot：交互友好，在独立 chat 页面聊天，我不习惯在侧边栏使用，**很少使用**；
2. quickadd ai assistant：不支持流式输出，**已放弃**；
3. local-gpt + ai-providers 组合：**在用**
4. `chatgpt-md`：**在用**

**chatgpt-md** 的特点让我强烈推荐的原因有以下 3 点：
1. 支持 `多轮对话`，能在 markdown 里面看到每次对话的内容，且能**随时修改对话的内容**，这是其他插件不能实现的优势。
2. `chatgpt-md` 插件正如其名（ai+markdown 的组合），提示词都和模型参数都是在**笔记**内**一站式配置**，编辑后执行 `infer title` 生成标题，`体验非常紧凑`；
3. 支持基于 **OpenRouter** 集成全网 AI 大模型，这个是单一 AI 平台无法比拟的优势；

## 结语
AI 不是遥不可及的黑科技，只要搭配得当，它可以是你笔记里的贴身助手。
不用折腾配置、不用切来切去，写完笔记直接问 AI 就行。
如果你也想在自己的知识管理引入 AI，不妨试试 `Obsidian` + `OpenRouter` 这套组合。
