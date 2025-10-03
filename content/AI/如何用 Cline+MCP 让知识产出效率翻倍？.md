---
title: 如何用 Cline+MCP 让知识产出效率翻倍？
aliases: [如何用 Cline+MCP 让知识产出效率翻倍？]
tags: [AI, 极客工具]
created: 2025-03-13T21:39:25
updated: 2025-10-03T20:37:51
draft: false
---
![[file-20251002111758598.png]]
Cline+MCP 打造 AI 写作工作流：通过 MCP 标准化接口，一键调用网页抓取（Fetch）与智能搜索（Tavily）， 5 分钟完成术语提炼、专业释义与千字初稿。
用 AI 解放生产力，让创作者专注深度思考——技术工具终为人类思维服务。

# 如何用 Cline+MCP 让知识产出效率翻倍？

如果出来一个新的技术，我想输出分享，势必要四处搜资料输入，但是现在有 `Cline+MCP`,我可以和 AI 这么说:

> 请采集指定网页文章链接 (url1,url2)，整理成结构清晰、语言流畅的博客。要求：
 1.提炼核心术语/概念，补充搜索引擎释义段落；
 2.符合 " 极客工具 " 品牌定位（开源技术赋能个人成长）；
 3.适配微信/知乎等平台传播，兼具专业性与可读性。字数控制在 1000-1500 字。

然后一篇文章几分钟就能整理到位，剩下我自己做做改动，自己领会就能发布了。

今天介绍下 `如何使用 AI 辅助公众号写作：Cline+MCP`,这篇内容的术语有 AI 辅助的功劳，更多的是我实操的分享。

## MCP 是做什么的？

> MCP 的核心价值在于提供 `标准化接口`，就像苹果最终放弃专有的 Lightning 接口转而采用 USB-C 一样，MCP 的存在让 AI 应用能轻松切换不同模型，同时让模型轻松对接各种数据源和工具。

MCP（Model Context Protocol, https://github.com/modelcontextprotocol）
MCP 的核心价值在于标准化，简化 AI 模型与外部资源的连接，推动更强大、实用的 AI 应用开发。

Agent 中的 `function calling` 允许开发者自定义函数和调用方式，灵活性高，但缺乏统一标准，导致不同开发者之间的实现难以通用，增加了重复开发成本。

`Anthropic` 开源的 MCP 协议旨在解决这一问题，类似于 `USB-C` 的通用接口，提供标准化连接方式。MCP 使得 AI 应用可以轻松切换不同模型，并让模型无缝对接各种数据源和工具，提升开发效率和兼容性。

## AI 写作 - 环境准备
### uv 安装
安装文档： https://docs.astral.sh/uv/getting-started/installation/

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### npx 安装

```bash
npm install -g npx
```

### cline 配置大模型
1. vscode 中安装 cline 插件。
2. Api Provider 里面国外有些模型用不了的话，可以选置 `OpenAI Compatible`。

![如何使用AI辅助公众号写作：Cline+MCP image 20250313 6|563x445](file-20251002111758829.png)

我在使用国内的大模型的一站式云服务平台 `硅基流动`( https://cloud.siliconflow.cn/i/CiNvLufj) 。
注册可输入极客工具的邀请码：CiNvLufj，送 2000 万 token。siliconflow 的模型广场里面看了下有 40 多个 AI 模型可以在线使用（有 20 多个是免费的），比如常见的 `deepseek`，`qwen` 系列。

## AI 写作 - 工具配置
工具：
1. `fetch`：api 采集网页数据，需要遵循 robot 协议；
2. `playwright`：rpa 采集网页数据，更通用，但是速度慢，相比 fetch 能力强但是稳定性低一些；
3. `tavily`：搜索引擎 API，可有限次的免费使用
![如何使用AI辅助公众号写作：Cline+MCP image 20250313](file-20251002111758962.png)

我的参考配置

```json
{
  "mcpServers": {
    "fetch": {
      "command": "python",
      "args": [
        "-m",
        "mcp_server_fetch"
      ],
      "autoApprove": [
        "fetch"
      ]
    },
    "tavily-mcp": {
      "command": "npx",
      "args": [
        "-y",
        "tavily-mcp@0.1.2"
      ],
      "env": {
        "TAVILY_API_KEY": "tvly-dev-your-key"
      },
      "autoApprove": [
        "tavily-search"
      ]
    }
  }
}
```

这期先讲简单的 fetch+tavily 的组合

### mcp 安装搜索引擎 - tavily
用 github/google 账号注册，tavily 每个月 1000 次免费搜索

安装地址： https://github.com/tavily-ai/tavily-mcp

### mcp 安装网页爬虫 - fetch
安装地址： https://github.com/zcaceres/fetch-mcp

### cline 自动安装 mcp
也可以输入提示词，让 cline 自动安装，不过容易出错，有能力的同学建议手动来，更快。

![如何使用AI辅助公众号写作：Cline+MCP Screenshot from 2025 03 13 21 45 29 20250313](file-20251002111759057.png)

## AI 写作 - 流程截图
fetch 网页采集
![如何使用AI辅助公众号写作：Cline+MCP image 20250313 1](file-20251002111759281.png)

fetch 网页采集结果存储
![如何使用AI辅助公众号写作：Cline+MCP image 20250313 2](file-20251002111759458.png)

tavily 搜索知识点
![如何使用AI辅助公众号写作：Cline+MCP image 20250313 3](file-20251002111759588.png)

结果存为本地 markdown
![如何使用AI辅助公众号写作：Cline+MCP image 20250313 4](file-20251002111759692.png)

📌 总结
在 AI 技术狂飙的今天，`Cline+MCP` 组合像一把「极客瑞士军刀」，用标准化协议切开技术壁垒，让 `内容创作` 从 `信息泥潭` 中解放。通过 `自动采集`、`语义提炼` 与 `品牌化适配`，我们不再被重复劳动束缚，而是将精力聚焦于 `深度思考` 与 `价值传递`。

我始终相信：开源工具不是替代创造力，而是为每个个体装上 `思维外骨骼`。
技术终将服务于那些 `永远好奇` 的人。
