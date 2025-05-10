---
draft: false
title: Obsidian+AI新玩法：免费实现多轮对话与模型自由
aliases: ["**Obsidian+AI 新玩法：免费实现多轮对话与模型自由**", Obsidian+AI 新玩法：免费实现多轮对话与模型自由]
tags: []
created: 2025-04-22T07:11:09
updated: 2025-05-10T09:59:36
---
![[Obsidian+AI新玩法：免费实现多轮对话与模型自由-20250422080022.png]]

# Obsidian+AI 新玩法：免费实现多轮对话与模型自由

想在 Obsidian 里直接对话 ChatGPT，还能改对话内容？这款 chatgpt-md 插件做到了。不止支持 OpenAI，还能接入 OpenRouter 和本地 Ollama 模型，灵活又好用！

## 插件介绍
- 插件 ID: **chatgpt-md**
- 项目地址: https://github.com/bramses/chatgpt-md
- 项目描述: 让 ChatGPT 与 Obsidian 的（几乎）无缝集成。
- 支持配置 3 类模型：每个 AI 服务现在在设置和元数据中都有自己的专用 URL 参数
	- openaiUrl 用于 `OpenAI` API
	- openrouterUrl 用于 `OpenRouter.ai`
	- ollamaUrl 用于 `Ollama` 本地模型

### chatgpt-md 插件演示
上次粉丝留言反馈说不知道怎么使用这个插件，这期专门录屏给大家手把手教学，逐个参数都给你说清楚。

![[Obsidian AI 插件实践苏格拉底学习：ChatGPT MD-20250422074440.mp4]]
演示内容
1. chatgpt-md 插件配置
2. chatgpt-md 插件特点
	1. `多轮对话`，能在 markdown 里面看到每次对话的内容，且能**随时修改对话的内容**，这是其他插件不能实现的优势
	2. 提示词都和模型参数都是在**笔记**内**一站式配置**，编辑后执行 `infer title` 生成标题，`体验非常紧凑`；

## AI 服务配置
使用 free_chat_gpt_api 和 openrouter.ai 实现免费使用 AI，如 credit 不够，可在 open_router 中充值付费即可

### 公益免费的 OpenAI 接口
项目： https://github.com/popjane/free_chatgpt_api

完全免费使用以下勾选模型：
- [x] gpt-4o-mini（速度一般，若要体验极速回复，可购买付费 API）
- [x] gpt-3.5-turbo-0125
- [x] gpt-3.5-turbo-1106
- [x] gpt-3.5-turbo
- [x] gpt-3.5-turbo-16k
- [x] net-gpt-3.5-turbo (可联网搜索模型 - 稳定性稍差)
- [x] whisper-1
- [x] dall-e-2

点击领取免费的 api key： https://free.v36.cm/github
API URL: https://free.v36.cm

### OpenRouter 的免费的聚合 API 接口
服务： https://openrouter.ai

openrouter 提供以下免费的模型使用

#### 🧠 Google

| 模型名称                                   | 上下文窗口                          |
| -------------------------------------- | ------------------------------ |
| Gemini 2.5 Pro Experimental            | 1,000,000                      |
| Gemini 2.0 Flash Experimental          | 1,048,576                      |
| Gemini 2.0 Flash Thinking Experimental | 40,000                         |
| LearnLM 1.5 Pro Experimental           | 40,960                         |
| Gemma 3 27B / 12B / 4B / 1B            | 各 131,072（部分为 96,000 或 32,768） |
| Gemma 2 9B                             | 8,192                          |

#### 🔍 DeepSeek

|模型名称|上下文窗口|
|---|---|
|DeepSeek V3 0324 / Base|163,840|
|DeepSeek Chat（旧版）|163,840|
|R1 / R1 Zero|163,840|
|R1 Distill Llama 70B|128,000|
|R1 Distill Qwen 32B / 14B|16,000 / 64,000|

#### 🔋 NVIDIA

|模型名称|上下文窗口|
|---|---|
|Llama 3.1 Nemotron Ultra 253B|131,072|
|Llama 3.1 Nemotron 70B Instruct|131,072|
|Llama 3.1 Nemotron Nano 8B|131,072|
|Llama 3.3 Nemotron Super 49B|131,072|

#### 🦙 Meta (Llama 系列)

|模型名称|上下文窗口|
|---|---|
|Llama 3.3 70B Instruct|8,000|
|Llama 3.2 Vision 11B|131,072|
|Llama 3.2 3B / 1B|20,000 / 131,072|
|Llama 3.1 405B (base)|64,000|
|Llama 3.1 8B Instruct|131,072|
|Llama 4 Maverick|256,000|
|Llama 4 Scout|512,000|

#### 🇨🇳 Qwen (阿里)

|模型名称|上下文窗口|
|---|---|
|Qwen2.5 7B / 72B / 32B Coder|32,768|
|Qwen2.5 VL 72B / 32B / 7B / 3B|131,072 / 8,192 / 64,000 / 64,000|
|QwQ 32B / Preview|40,000 / 16,384|

# 结语
无论是实时修改对话记录，随时切换模型，还是用免费 API 薅 GPT-4o 的羊毛，`chatgpt-md` 插件的设计都精准踩中了知识工作者的刚需。
一边记笔记一边和 AI 深聊，无需切换到网站，免费加持，省心又省钱，推荐一试。
