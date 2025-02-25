---
comment: true
draft: false
modified: 2025-02-22 23:02:40
title: 我的工具库 -2025
aliases: [我的工具库 -2025]
tags: [NAS, Obsidian, RSS, Ubuntu, 工具]
created: 2025-02-20 20:02:00
updated: 2025-02-25 09:50:06
---

![[xtool-2025-1740054124101.jpeg]]

# 我的工具库 -2025

> 分享全栈开发的知识管理工具实践，用 obsidian+ai 构建「第二大脑」

## 我的知识管理经历

从 2008 年开始写第一行 HelloWorld 代码，牛马之路就一发不可收拾…

1. 2010 年之前，纯草稿 + 纯待办：十几个草稿本
	* 解决当时的遗忘问题；
	* 没有再翻过一次，没有任何意义，可能老了可以留个念想 `-_-`；
2. 2012 年，离线的笔记软件
	* 换汤不换药，用软件零碎的做着草稿，待办和按时间线的笔记；
	* 按主题分类，企图建立个人知识库，经常陷入采集到的知识不知道如何分类的困境；
3. 2016 年，个人博客 + 印象笔记
	* 使用日事清的四象限 TODO 法做 GTD；
	* 看书，RSS 订阅博客，用心做笔记，由项目/技术学习推进做笔记总结；
	* 用 markdown 写博客，用 hexo 发布，写了 5 年，到 2021 年后没有再分享，只在本地做了，evernote 要转 markdown 得手动编辑，长期以往让人疲乏；
4. 2020 年 -2023 年，探索双链笔记
	* 每次陷入混乱，就会从零开始整理自己的知识库，感觉根源还是在知识整理的方法不对；
	* 印象笔记：做了大量剪藏，很多不看（松鼠症），markdown 的支持不好，生态封闭，最终放弃，我还买了 5 年的会员，囧；
	* Flomo 碎片化笔记：移动端随时记录闪念，或是作为树洞避免脑子记得事情多导致压力大；
	* 思源笔记：学习卡片式笔记法，接触到 siyuan，开始用它记录工作日志，知识总结，但是后来思源由 markdown 改为自己的 json 格式，不再透明，这很不利于本地化和开放的笔记生态对接，放弃迁移到 obsidian；
5. 2023 年 -NOW，Obsidian 一站式学习 +AI 驱动
	* 用 obsidian 实践双链笔记，作为工作生活的入口，重建外部大脑；
	* 2025 年 DeepSeek 横空出世，AI 使用成本低效果好，我又自信了。我干过全栈，日常爱在 NAS 折腾开源工具，现在又多了聪明的智能助手，超级个体的梦又熊熊燃烧了，于是又开始写博客分享，以输出驱动输入；
	* 开通公众号：`极客工具 XTool`，继续探索开源项目，共享开源力量，成就超级个体

> Obsidian 的设计，骨子里透着一股 Linux 的味道：**用户拥有绝对控制权**！

毫不夸张地说，Obsidian 简直是笔记工具界的天花板，普通用户能摸到的最高境界。

用别的笔记软件，如果你有个好想法但工具不支持，那只能默默叹气，无可奈何。但 Obsidian 不一样，它就像个开源乐园，你可以去社区淘插件，甚至自己动手写一个。

## 我的知识管理流程

1. 知识收集：rss（miniflux）
2. 知识加工：obsidian
3. 知识分享：quartz

> 这期写工具，后面专门写 obsidian 的系列来串工作流程

## 知识管理工具

我现在每天打开电脑都是从 obsidian 开始，开机 obsidian 自动启动并打开历史未完成的待办，所有输入都以 obsidian 作为输出。

### obsidian 的插件列表

1. 同步：obsidian livesync+couchdb
2. 备份：git
3. 搜索：omni-search
4. 编辑：image-converter，various-complements
5. 格式化：linter
6. 日记：templater，quickadd
7. 待办：tasks，tasks calender wrapper

> 其实还安装了很多，列出来的是贯穿日常工作流的核心插件，后续会专门详细写个人工作流与 obsidian 的实践

### 知识收集工具

1. rss 阅读
	* 服务端：miniflux
	* 安卓客户端：fluent-reader
2. 系统阅读：微信阅读，微信听书，多看阅读，得到
3. 碎片化：BiliBili,YoutubeBox,小红书，微博
4. 语言打卡：多邻国，粤语，英语，打了 533 天，继续刚把得

## 开发工具

### 开发硬件

1. 笔记本：thinkpad-t14，16 核 32G
2. NAS：某宝捡垃圾组的
	* CPU：至强 E5-2680v4-14 核 28 线程；
	* 内存：DDR4，64G；
	* 显卡：微星 GTX1650
3. 米家智能家居：小米网关，智能插座
4. 路由器：京东无线云
5. 语音助手：天猫精灵

### 开发软件

1. 技术栈
	* 语言：java，kotlin，python，javascript，shell
	* 技术：spring,spark,flink
2. 开发环境
	* jetbrain-idea
	* jetbrain-pycharm
	* jetbrain-datagrip
	* visual studio code

## 操作系统

### ubuntu

1. 系统制作：etcher(linux),woe-usb(windows)
2. 快捷指令：utools
3. 桌面切换：wmctrl
4. 文件管理器：superfile
5. 命令行：ob-my-zsh
6. terminal 会话管理：tmuxp
7. terminal 历史搜索：atuin
8. terminal 助手：aichat
9. 远程自动化：ansibe playbook
10. 虚拟化：docker，virtualbox：windows 虚拟机使用企微
11. UML 设计：staruml
12. 邮件客户端：thunderbird

## NAS 系统

1. nas 系统：truenas scale
2. nas 客户端：serverbox
3. 可道云：个人云盘，包含 andoird 客户端
4. 家庭影院：jellyfin
5. 相册管理：photoprism
6. 数据库：mariadb，postgresql，redis，couchdb
7. 财务管理：firefly
8. 密码管理：vaultwarden
9. 动态 DNS：duckdns

### google chrome

1. Proxy SwitchOmega
2. AdBlock
3. BitWarden Password Manager
4. Obsidian Web Clipper
	* 采集知识到 obsidian 的未归档目录，定时阅读后纳入知识体系
	* 可以配置 AI 自动总结来提高阅读效率

## 其他工具

1. 密码管理：vaultwarden 客户端 keyguard
2. 二阶段密码管理：aegis
3. 财务管理：firefly 客户端 abacus
4. KX 上网：
	* 服务端：V2ray
	* 客户端：V2rayNG
5. 输入法：
	* 手机端：微信输入法
	* PC 端：google 输入法（微信输入法是香，可惜没有 linux 版的）
6. 本地文件管理：mix-explorer,es 文件浏览器
7. 远程备份：一刻相册
8. Office 办公：wps
9. 视频剪辑：剪映
10. 外部协作：腾讯文档，金山日历
11. 手机端 Linux 环境: termux,anLinux
12. 户外运动：小米手环，两步路户外助手
13. 屏蔽广告：李跳跳
14. 应用：APKPure，XAPK Installer
15. 音乐：网易云音乐
16. AI 助手：deepseek，hugging-chat，心流，豆包，kimi，秘塔

这一通梳理下来，我真是服了自己！为了讨生活，竟然依赖这么多工具，简直是个 " 工具控🛠️ " ！

不禁让我好奇，在没有互联网的年代，父辈们到底是怎么活下来的？他们的工具清单上，会不会只有锤子、螺丝刀和一本老黄历🔨📅？

上面列的工具是我用得还算顺手的。

各位工友们，如果你们有更好的 " 神器 "，千万别藏着掖着，赶紧分享出来！

毕竟咱们现在可是活在 AI 时代，一切不够智能的工具，都可以重新 "AI 化 " 一遍🤖✨