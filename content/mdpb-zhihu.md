---
draft: false
title: mdpb-zhihu
aliases: [用 OpenManus 全自动发布文章到知乎]
tags: [Obsidian, 自动化发布]
created: 2025-03-08T09:52:03
updated: 2025-05-10T09:59:37
---
![[agent-metagpt-manus-cover.png|736x414]]
今天我们用 `全自动发布文章到知乎` 这个需求，看下目前的 OpenManus 类智能体做得到吗？（想知道结果的直接看文章尾部，送上我刚调试好的自动化发布工具）

# 用 OpenManus 全自动发布文章到知乎
这两天 Manus 用邀请码搞饥饿营销一通蹭热度的一套骚操作，各大网红用震惊体狂吹，感觉要飞上天和 DeepSeek 肩并肩。

刚听到 `Manus` 火的消息，我以为和 `Deepseek-R1` 一样又来了个技术大爆炸，结果一探究，原来不是底层大模型的突破，不是搞出了类似 `OpenAI` 的 `Deep ReSearch` 模型。Manus 就是 `工程化`（套壳）做的好，交互上，左边放实时看的炫酷的效果，右边放不明觉厉的代码，然后各种 tool 缝合出来个花里胡哨的帕鲁。

真要干点细致活，目前还是干不好的，比如：涉及数字计算的财务运算，比如全自动化编程。不过这不是 Manus 的问题，是行业现状，但 `Manus` 吹得牛比较大，还站在了风口。这不，7 号晚上下班 [OpenManus](https://github.com/mannaandpoem/OpenManus) 就出来了， [MetaGPT](https://github.com/geekan/MetaGPT) 的 5 个做智能体的小哥 3 小时卷出来的，啪啪打脸。

有东西吧你就开源，这样我好分享给大伙儿。我也敬你是条汉子，别整这些虚头巴闹的邀请码，不是长远的事儿，得学学国内开源的其他 AI 产品：LLMOps 有 Dify，LobeChat；面向终端客户有 CherryStudio 的，那都低调做事的团队，产品都是做的没有二话。

Ok，言归正传，现在和大家说下 manus 这类产品的原理和技术现状

## 实现原理
具体是用 `multi agent` 思路，组合现有的工具栈做的智能体：
1. LLM：支持 tool 的 sass 大模型服务，比如 openai 的 gpt-4o,阿里 qwq
2. 联网搜索：搜索引擎 api，比如 google/bing/tavily/kagi 之类的搜索厂商
3. 浏览器使用：比如开源的 [browser-use](https://github.com/browser-use/browser-use)，基于 rpa 库 [playwright](https://github.com/microsoft/playwright) 操作浏览器和键盘鼠标
4. python/shell 编程：类似 cursor，cline,deepseek-coder
5. 程序部署：基于 docker 的 shell 命令

OpenManus 我 clone 下来用 阿里的 qwq 模型 作为 llm 体验了下，对我来说，暂时没啥用，还是个 demo，不够成熟，很多 bug，固定 30 步死慢死慢。体验还没他家 `MetaGPT` 做的好，感觉也是看不惯 Manus，搞出来纯蹭一波热点。

## MetaGPT 介绍
好了，回到 AI 生产力这件事，我按自然语言描述我的需求，然后用稍成熟的 [MetaGPT](https://github.com/geekan/MetaGPT) 来测试一波（MetaGPT 在 github 有 50k star,迭代了 2 年 20 个版本）。

MetaGPT 大体是模拟一家软件公司的开发流程,不过是模拟各个角色让 AI 干活。
![[用OpenManus全自动发布文章到知乎-image-20250308-1.png|1080x608]]

依赖的工具链如下
![[用OpenManus全自动发布文章到知乎-image-20250308.png|1080x497]]

## MetaGPT 实战
我的需求描述

```markdown
实现一个自动将本地markdown发布到知乎的程序

1. 读取本地markdown文件：/mnt/gogs/kbase/obsidian/01Project/Blog/draft/open-manus.md

2. 使用playwright库，以connect_over_cdp方式使用本地浏览器，新建tab打开：https://markdown.com.cn/editor/，然后点击右上侧的按钮（复制到知乎）。

3. 打开知乎文章发布页：https://zhuanlan.zhihu.com/write，根据markdown的内容输入标题和正文。从正文提取主图，设置投稿至问题，添加3个文章话题​，点击发布。
```

MetaGPT 生成的文件结构如下

```bash
├── docs                                                                                    
│   ├── class_view                          
│   ├── code_plan_and_change
│   ├── code_summary                                                                        
│   ├── graph_repo                                                                          
│   ├── prd（需求描述）                                                                                 
│   │   └── 20250308085344.json                                                             
│   ├── system_design（系统设计）                                                      
│   │   └── 20250308085344.json                                                             
│   ├── task（开发任务）                                    
│   │   └── 20250308085344.json           
│   └── requirement.txt
├── markdown_to_zhihu（最终输出程序）
│   ├── config.py
│   ├── main.py
│   ├── markdown_parser.py
│   └── zhihu_publisher.py
├── resources（生成的中间结果）
│   ├── api_spec_and_task
│   ├── code_plan_and_change
│   ├── code_summary
│   ├── competitive_analysis
│   │   └── 20250308085344.mmd
│   ├── data_api_design
│   │   └── 20250308085344.mmd
│   ├── graph_db
│   ├── prd
│   │   └── 20250308085344.md
│   ├── sd_output
│   ├── seq_flow
│   │   └── 20250308085344.mmd
│   └── system_design
│       └── 20250308085344.md
├── test_outputs
├── tests
└── requirements.txt
```

比如：需求文档是用 json 这样描述的

```json
{
  "Language": "zh_cn",
  "Programming Language": "Python",
  "Original Requirements": "实现一个自动将本地markdown发布到知乎的程序",
  "Project Name": "markdown_to_zhihu",
  "Product Goals": [
    "实现自动化发布流程，减少用户操作步骤",
    "确保发布内容的准确性和完整性",
    "提升用户体验，简化发布流程"
  ],
  "User Stories": [
    "作为一个用户，我希望能够自动将本地的markdown文件发布到知乎，减少手动操作",
    "作为一个用户，我希望程序能够自动提取markdown中的主图并设置投稿问题",
    "作为一个用户，我希望程序能够自动添加文章话题，提升文章曝光率"
  ],
  "Competitive Analysis": [
    "知乎官方发布工具：功能全面，但需要手动操作，无法自动化",
    "第三方markdown发布工具：支持多种平台，但无法直接发布到知乎",
    "自动化脚本工具：支持自定义自动化流程，但需要用户具备编程能力"
  ],
  "Requirement Pool": [
    [
      "P0",
      "实现读取本地markdown文件的功能"
    ],
    [
      "P0",
      "使用playwright库自动化操作浏览器"
    ],
    [
      "P1",
      "自动提取markdown中的主图并设置投稿问题"
    ],
    [
      "P1",
      "自动添加文章话题"
    ],
    [
      "P2",
      "优化发布流程，提升用户体验"
    ]
  ],
  "UI Design draft": "该程序为命令行工具，无需复杂UI设计，主要通过命令行参数和配置文件进行操作。",
  "Anything UNCLEAR": "是否需要支持其他平台的发布功能？是否需要支持多用户并发操作？"
}
```

具体过程如下,最终代码审查通过，中间几轮自我审查 `LBTM` 反复修改，一通操作以 `LGTM` 结束。

![MetaGPT工作视频](metagpt-demo.mp4)
实际最终代码我看了一遍，写的很工整规范，注释也很清楚，逻辑看着貌似都是对的，但是一细究，会发现到知乎填充内容时 dom 的选择都是想当然的，只能参考，没法直接运行。

## 当下的方案
总结下来，目前有几个核心难处。
1. 各媒体网站产品用户是面向人，而不是机器，还有很多反爬策略，网站设计的都没有开放接口，比如 AI 面对短信验证码来 `授权` 确认，这类需要物理世界交互的智能体就不知道怎么弄。
2. 目前用 AI 写的前端代码/交互/视觉上是可以做到很好的，但是 `后端逻辑复杂`，上下文长，AI 写出来的代码很多不靠谱，只能给程序员参考，不能直接运行。
3. 因为 AI 有 `幻觉`，且目前的输入 token 有长度限制，OpenManus 之类 MultiAgent 不得不将 1 个长任务拆分成 30 个子任务，那如果中间有几个出现幻觉，就会导致错的离谱。
那我要实现上面的需求，要怎么弄？还得依赖牛马程序员来干。

具体思路：
1. 把上面的需求，在 `cursor` 里面描述，cursor 生成基础代码;
2. 在浏览器人工调试；
3. 在 cursor 里面使用 AI 反复修改,直到满足条件；
4. 固化一个可执行的 python 脚本，分享给大伙儿。

最终实现效果如下：
![[md-auto-publish-tool.mp4]]

## 总结
如题，目标是：用 OpenManus 全自动发布文章到 [知乎-极客工具](https://www.zhihu.com/people/geosmartx) 帐号，
我试过了，AI 目前还搞不定，饭碗暂时是保住了。

之前为了高效输出，分享了 [obsidian内如何搞定自动传图和一键排版](https://mp.weixin.qq.com/s/RLiGAkef_w1w-SxLb51SlQ)。

然后为了能一篇文章能多平台发布，收获更多的反馈，调研了 [商业/开源的多平台发布工具](https://mp.weixin.qq.com/s/4QejiWD8b6STwPvPGUw2FQ)，结果发现市场上的工具都存在格式错乱的问题，且很多都需要手动操作，不能满足我对自动化的高要求。

所以在家实现了这个 `本地Markdown全自动发布文章到知乎的工具`，现在分享出来，
需要的朋友公众号留言:`极客工具自动发布` 获取
